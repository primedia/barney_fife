class GenerateReport
  include Interactor::Organizer

  organize [
            PrepareRepository,
            RunRubocop,
            AddOffensesCommentsToGitHub,
            UpdateGitHubCommitStatus
           ]
end
