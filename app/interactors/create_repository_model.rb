class CreateRepositoryModel
  include Interactor

  def perform
    name, org = context.values_at(:name, :organization)
    repo = Repository.new(name: name, organization: org)
    if repo.save
      context[:repository] = repo
    else
      context.fail!
    end
  end
end
