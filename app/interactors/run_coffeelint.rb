class RunCoffeelint
  include Interactor

  def perform
    fuzz = DaleCooper::Coffeelint::Investigation.call(context[:pull_request])
    presenter = DaleCooper::Coffeelint::InvestigationPresenter.new(fuzz)

    context[:offenses] = Array(context[:offenses]) + presenter.offenses
    context[:no_errors] = context[:no_errors] && presenter.success?
  end

end
