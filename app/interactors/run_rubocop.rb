class RunRubocop
  include Interactor

  def perform
    fuzz = BarneyFife::Rubocop::Investigation.call(context[:pull_request])
    presenter = BarneyFife::Rubocop::InvestigationPresenter.new(fuzz)

    context[:offenses] = Array(context[:offenses]) + presenter.offenses
    context[:no_errors] = true if presenter.success?
  end

end
