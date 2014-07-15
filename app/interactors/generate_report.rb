class GenerateReport
  include Interactor::Organizer

  organize [
            PrepareRepository,
            RunLinters,
            AddOffensesCommentsToGitHub,
            UpdateGitHubCommitStatus
           ]
end
