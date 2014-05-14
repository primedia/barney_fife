class RegisterGitHubWebhook
  include Interactor

  def perform
    repo = context[:repository]
    url  = context[:url]
    GitHub::WebhookRegistrar.register_pull_request_webhook(repo.full_name, url)
  end
end
