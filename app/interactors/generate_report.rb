class GenerateReport
  include Interactor::Organizer

  organize UpdateRepo, RunRubocop, AddOffensesCommentsToGitHub, UpdateGitHubCommitStatus
end
