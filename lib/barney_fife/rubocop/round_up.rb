module BarneyFife
  module Rubocop
    class RoundUp
      attr_accessor :pull_request_number, :response, :response_body, :client, :owner, :repo, :repo_full_name

      SHA_REGEX = %r{[a-f0-9]{40,40}/}

      def initialize(pr, client = GitHub::Client)
        @pull_request_number, @owner, @repo, @client = pr.pull_request_number, pr.owner, pr.repo, client
        @repo_full_name = pr.full_name
      end

      def self.call(pull_request, tmpdir)
        round = new(pull_request)
        round.gather_pull_request
        round.download_files(tmpdir)
      end

      def api
        @api ||= Faraday.new 'https://api.github.com' do |conn|
          conn.use Faraday::Request::BasicAuthentication, ENV['GITHUB_AUTH_TOKEN'], 'x-oauth-basic'
          conn.request :json

          conn.response :json, :content_type => /\bjson$/
          conn.use :instrumentation
          conn.adapter Faraday.default_adapter
        end
      end

      def gather_commits
        # GET /repos/:owner/:repo/pulls/:number/commits
        @commits ||= client.pull_request_commits(repo_full_name, pull_request_number)
      end

      def files_modified
        @files_modified ||= client.pull_request_files(repo_full_name, pull_request_number)
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
        Base64.decode64(api.get(content_url).body['content'])
      end

      def dirs_to_create(shortname)
        shortname.split(File::SEPARATOR)[0..-2].join(File::SEPARATOR)
      end

      def download_files(tmp_rubodir, files = files_modified)
        files.peach do |file|
          content_url = file.contents_url.split('https://api.github.com')[1]
          file_shortname = split_on_sha(file.raw_url)
          necessary_dir = dirs_to_create(file_shortname)
          filename = file_shortname.split(File::SEPARATOR).last
          file_dir = File.join(tmp_rubodir, necessary_dir)

          unless Dir.exists?(file_dir)
            FileUtils.mkdir_p(file_dir)
          end

          File.open(File.join(file_dir, filename), 'wb') do |wfile|
            wfile.write(get_file(content_url))
          end
        end
      end
    end
  end
end
