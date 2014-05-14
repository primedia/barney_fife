class RegisterGitHubWebhook
  include Interactor

  def perform
    repo = Repository.find_by_id(context[:repo_id])
    url  = context[:url]
    GitHub::WebhookRegistrar.register_pull_request_webhook(repo.full_name, url)
  end
end
