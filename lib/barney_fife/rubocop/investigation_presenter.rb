module BarneyFife
  module Rubocop
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

    end

  end
end
