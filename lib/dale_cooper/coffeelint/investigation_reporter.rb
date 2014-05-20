module DaleCooper
  module Coffeelint
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

      def success?
        summary.offense_count < 1
      end

      def offenses
        files.each_with_object([]) do |file, issues|
          file.offenses.each do |offense|
            issues << ::Rubocop::Offense.new(path: file['path'], location: offense['location'], cop_name: offense['cop_name'], message: offense['message'])
          end
        end
      end

      def files
        json_output["files"]
      end
    end
  end
end
