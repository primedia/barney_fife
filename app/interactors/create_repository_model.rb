class CreateRepositoryModel
  include Interactor

  def perform
    repo = Repository.new(context[:repository_params])
    if repo.save
      context[:repository] = repo
    else
      context.fail!
    end
  end
end
