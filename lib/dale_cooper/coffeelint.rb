module DaleCooper
  module Coffeelint
    COFFEELINT_CMD = "coffeelint"

    def self.run(pull_request)
      fuzz = DaleCooper::Coffeelint::Investigation.call(pull_request)
      DaleCooper::Coffeelint::InvestigationPresenter.new(fuzz)
    end
  end
end
