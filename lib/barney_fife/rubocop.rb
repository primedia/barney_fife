module BarneyFife
  module Rubocop
    RUBOCOP_CMD = 'rubocop'

    def self.run(pull_request)
      Dir.mktmpdir('rubocop') do |tmpdir|
        RoundUp.call(pull_request, tmpdir)
        fuzz = Investigation.call(tmpdir)
        InvestigationPresenter.new(fuzz)
      end
    end
  end
end

