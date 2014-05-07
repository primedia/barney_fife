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
        final_cmd = ['rubocop', colorless_clang_cmd, json_cmd(file.path), file_list].join(' ')
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
  end
end

