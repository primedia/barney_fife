class GenerateReport
  include Interactor::Organizer

  organize RunRubocop, AddOffensesCommentsToGitHub, UpdateGitHubCommitStatus
end
