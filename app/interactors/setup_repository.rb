class SetupRepository
  include Interactor::Organizer

  organize CreateRepositoryModel, CloneRepositoryLocally, RegisterGitHubWebhook
end
