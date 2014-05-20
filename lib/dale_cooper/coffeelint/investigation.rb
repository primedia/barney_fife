module DaleCooper
  module Coffeelint
    class Investigation
      attr_accessor :files, :tmpdir, :human_output, :json_output,\
                    :pull_request_number, :response, :response_body,\
                    :client, :owner, :repo, :repo_full_name

      def self.call(pull_request)
        investigation = new(pull_request)
        investigation.gather_coffeelint_inspection
        investigation
      end

      def initialize(pr, client = GitHub::Client)
        @pull_request_number, @owner, @repo, @client = pr.pull_request_number, pr.owner, pr.repo, client
        @repo_full_name = pr.repo_full_name
      end

      def repo_dir
        @repo_dir ||= File.join(Rails.configuration.repo_dir, repo_full_name)
      end

      def files_modified
        @files_modified ||= client.pull_request_files(repo_full_name, pull_request_number)
                                  .map { |i| File.join(repo_dir, i.filename) }
      end

      def gather_coffeelint_inspection(file_list = files_modified)
        file = Tempfile.new('coffeelint_json')
        final_cmd = [COFFEELINT_CMD, file_list.join(' '), json_cmd(file.path)].join(' ')
        warn final_cmd
        output, status = Bundler.with_clean_env do
          Dir.chdir(repo_dir) do
            Open3.capture2("#{final_cmd}")
          end
        end
        @human_output = humanize_output(output)

        puts "****************#{@human_output}"
        @json_output = hashify(read_json(file.path))
      ensure
        file.close
        file.unlink
      end

      def json_cmd(path)
        "--reporter raw > #{path}"
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
