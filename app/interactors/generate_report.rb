class GenerateReport
  include Interactor::Organizer

  #TODO: verify behavior of AddOffensesCommentsToGitHub, UpdateGitHubCommitStatus
  organize PrepareRepository, RunRubocop, AddOffensesCommentsToGitHub, UpdateGitHubCommitStatus
end
