class RunRubocop
  include Interactor

  def perform
    presenter = BarneyFife::Rubocop.run(context[:pull_request])

    context[:offenses] = Array(context[:offenses]) + presenter.offenses
    context[:no_errors] = true if presenter.success?
  end

end
