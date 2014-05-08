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
