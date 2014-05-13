module BarneyFife
  module Rubocop
    RUBOCOP_CMD = 'rubocop'

    def self.run(pull_request)
      Dir.mktmpdir('rubocop') do |tmpdir|
        RoundUp.call(pull_request.pull_request_number, pull_request.owner, pull_request.repo, tmpdir)
        fuzz = Investigation.call(tmpdir)
        InvestigationPresenter.new(fuzz)
      end
    end
  end
end

