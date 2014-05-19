class UpdateGitHubCommitStatus
  include Interactor

  def perform
    pull_request = context[:pull_request]
    result       = context[:no_errors]

    status = GitHub::Status.new(pull_request.repo_full_name, pull_request.sha)

    result ? status.success! : status.failure!
  end
end
