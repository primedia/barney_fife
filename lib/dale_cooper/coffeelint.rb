module DaleCooper
  module Coffeelint
    COFFEELINT_CMD = "coffeelint"

    def self.run(pull_request)
      fuzz = Investigation.call(pull_request)
      InvestigationPresenter.new(fuzz)
    end
  end
end

