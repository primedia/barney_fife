require 'json'
require 'open3'
require 'tempfile'
require 'base64'

# external gems
require 'pmap'
require 'hashie'
require 'dotenv'
require 'faraday'
require 'faraday_middleware'
require 'octokit'

Dotenv.load!

module BarneyFife
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

    def gather_evidence(command, file_list = files)
      file = Tempfile.new('evidence_json')
      warn final_cmd = command
      output, status = Open3.capture2("#{final_cmd}")
      @human_output = humanize_output(output)
      @json_output = hashify(read_json(file.path))
    ensure
      file.close
      file.unlink
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

