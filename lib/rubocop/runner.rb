require 'json'
require 'open3'
require 'tempfile'
require 'base64'

# external gems
require 'rubocop'
require 'pmap'
require 'hashie'
require 'dotenv'
require 'faraday'
require 'faraday_middleware'
require 'octokit'

Dotenv.load!

# Run PRs through Rubocop Filter
# Process overview:
# - Receive PR hook (http://developer.github.com/v3/activity/events/types/#pullrequestevent)
# - When PR hook is opened/synchronize/re-opened, continue
# - Find out which files were changed (http://developer.github.com/v3/pulls/#list-pull-requests-files)
# -- Any file in json response Array 'added' or 'modified'?
# -- api.github.com/repos/:owner/:repo/pulls/:number/files
# -- 'https://api.github.com/repos/primedia/ag/pulls/100/files' ?
# - Mktmpdir and download all files into there
# - Run rubocop on that dir/those files
# `rubocop --format progress --format json --out rubocop.json`
# cli = Rubocop::CLI.new
# cli.run
#
# Get file via API
# https://stackoverflow.com/questions/17808702/smartest-way-to-grab-a-file-from-github-via-rest-api-or-ocktokit-ruby
# require 'octokit'
# require 'base64'
#
# api_response = Octokit.contents 'neilslater/games_dice',
#   :ref => 'v0.0.1', :path => 'README.md'
#   text_contents = Base64.decode64( api_response.content )
#   File.open( 'README.md', 'wb' ) { |file| file.puts text_contents }
#
# Didn't seem to work as well as straight api calls... maybe it will be easier at scale?

# Basic command
# `rubocop --format progress --out rubocop.progress --format json --out rubocop.json`


module BarneyFife
  module Rubocop
    RUBOCOP_CMD = 'rubocop'

    def self.run(opts = {})
      # Usage: presenter = BarneyFife::Rubocop.run(issue_number: '820', owner: 'primedia', repo: 'ag')
      issue_number = opts.fetch(:issue_number) { '820' }
      owner = opts.fetch(:owner) { 'primedia' }
      repo = opts.fetch(:repo) { 'ag' }
      Dir.mktmpdir('rubocop') do |tmpdir|
        RoundUp.call(issue_number, owner, repo, tmpdir)
        fuzz = Investigation.call(tmpdir)
        presenter = InvestigationPresenter.new(fuzz)
      end
    end

    class RoundUp
      attr_accessor :pull_request_number, :response, :response_body, :api, :client, :owner, :repo

      SHA_REGEX = /[a-f0-9]{40,40}\//

      def self.call(pull_request_number, owner, repo, tmpdir)
        round = new(pull_request_number, owner, repo)
        round.gather_pull_request
        round.download_files(tmpdir)
      end

      def initialize(pull_request_number, owner, repo)
        @pull_request_number = pull_request_number
        @owner = owner
        @repo = repo
        @client = Octokit::Client.new access_token: ENV['GITHUB_AUTH_TOKEN']
        @api = Faraday.new 'https://api.github.com' do |conn|
          conn.use Faraday::Request::BasicAuthentication, ENV['GITHUB_AUTH_TOKEN'], 'x-oauth-basic'
          conn.request :json

          conn.response :json, :content_type => /\bjson$/
          conn.use :instrumentation
          conn.adapter Faraday.default_adapter
        end
      end

        #gather all files from github PR files modified/added list
      def gather_pull_request
        @response_body ||= request_pr_info
      end

      def request_pr_info
        @response = @api.get "/repos/#{owner}/#{repo}/pulls/#{pull_request_number}/files"
        response.body.map { |item| Hashie::Mash.new(item) }
      end

      def files_modified
        @files_modified ||= response_body
      end

      def split_on_sha(url)
        url.split(SHA_REGEX)[1]
      end

      def extract_sha(url)
        url[SHA_REGEX]
      end

      def extract_repo(url)
        url.split('https://github.com/')[1].split('/raw')[0]
      end

      def get_file(content_url)
        Base64.decode64(api.get( content_url ).body['content'])
      end

      def dirs_to_create(shortname)
        shortname.split(File::SEPARATOR)[0..-2].join(File::SEPARATOR)
      end

      def download_files(tmp_rubodir, files = files_modified)
        files.peach do |file|
          raw_url = file.raw_url
          content_url = file.contents_url
          file_shortname = split_on_sha(raw_url)
          url_relative = raw_url.split('https://github.com')[1]
          content_url = content_url.split('https://api.github.com')[1]
          sha = extract_sha(raw_url)
          repo = extract_repo(raw_url)
          necessary_dir = dirs_to_create(file_shortname)
          filename = file_shortname.split(File::SEPARATOR)[-1]
          file_dir = File.join(tmp_rubodir, necessary_dir)
          unless Dir.exists?(file_dir)
            FileUtils.mkdir_p(file_dir)
          end
          content = get_file(content_url)
          File.write(File.join(file_dir, filename), content)
        end
      end
    end

    class Investigation
      attr_accessor :files, :tmpdir, :human_output, :json_output

      def self.call(tmpdir)
        investigation = new(tmpdir)
        investigation.gather_rubocop_inspection
        investigation
      end

      def initialize(tmpdir)
        @tmpdir = tmpdir
        @files = "#{tmpdir}/*"
      end

      def gather_rubocop_inspection(file_list = files)
        file = Tempfile.new('rubocop_json')
        final_cmd = [RUBOCOP_CMD, colorless_clang_cmd, json_cmd(file.path), file_list].join(' ')
        warn final_cmd
        output, status = Open3.capture2("#{final_cmd}")
        @human_output = humanize_output(output)
        @json_output = hashify(read_json(file.path))
      ensure
        file.close
        file.unlink
      end

      def json_cmd(path)
        "--format json --out #{path}"
      end

      def colorless_clang_cmd
        '--require ./lib/rubocop/clang_colorless_style_formatter.rb --format Rubocop::Formatter::ClangColorlessStyleFormatter'
      end

      def humanize_output(output)
        output.chomp
      end

      def read_json(path)
        JSON.parse(File.read(path))
      end

      def hashify(json)
        Hashie::Mash.new(json)
      end

      def summary
        @summary ||= json_output.summary
      end
    end

    class InvestigationPresenter < SimpleDelegator
      def present
      <<DOC
#{summary_line}

```
#{normalize_human_output}
```
DOC
      end

      def summary_line
        "Summary - Offences: #{summary.offence_count}, Files: #{summary.inspected_file_count}."
      end

      def normalize_human_output
        @normalized_human_output = human_output.gsub("#{tmpdir}/", '')
      end

    end
  end
end

