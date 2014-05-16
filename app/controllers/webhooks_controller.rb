class WebhooksController < ApplicationController

  def create
    if request.headers['X-GitHub-Event'] == 'pull_request'
      result = ::HandleWebhookResponse.perform(webhook_params)

      head (result.success? ? :ok : :internal_server_error)
    else
      head :no_content
    end
  end

  private

  def payload
    Hashie::Mash.new(params)
  end

  def webhook_params
    {
      owner: payload.repository.owner.login,
      repo: payload.repository.name,
      pull_request_number: payload.number.to_s,
      sha: payload.pull_request.head.sha,
      repo_full_name: payload.repository.full_name,
      ref: payload.pull_request.head.ref
    }
  end

end
