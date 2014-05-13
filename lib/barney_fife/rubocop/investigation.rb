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
        final_cmd = [RUBOCOP_CMD, colorless_clang_cmd, json_cmd(file.path), file_list].join(' ')
        warn final_cmd
        output, status = Bundler.with_clean_env do
          Open3.capture2("#{final_cmd}")
        end
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
        '--require ./lib/barney_fife/rubocop/clang_colorless_style_formatter.rb --format Rubocop::Formatter::ClangColorlessStyleFormatter'
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
