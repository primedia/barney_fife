module BarneyFife
  module Rubocop
    RUBOCOP_CMD = 'rubocop'

    def self.run(pull_request)
      fuzz = Investigation.call(pull_request)
      InvestigationPresenter.new(fuzz)
    end
  end
end

