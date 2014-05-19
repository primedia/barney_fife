module GitHub
  class WebhookRegistrar
    def self.register_pull_request_webhook(full_repo_name, callback_url)
      GitHub::Client.create_hook(full_repo_name, 'web', {url: "#{callback_url}/webhook", content_type: 'json'}, {events: ['pull_request'], active: true})
    # TODO: properly rescue when hook already exists
    rescue Octokit::UnprocessableEntity
    end
  end
end
