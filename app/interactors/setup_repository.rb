class SetupRepository
  include Interactor::Organizer

  organize CreateRepositoryModel, PrepareRepository, RegisterGitHubWebhook
end
