class CleanUpRepository
  include Interactor

  def perform
    name, org = context[:name], context[:organization]
    Git::Commands.new(name: name, org: org).reset
  end
end
