class RubocopController < ApplicationController

  def hook
    result = HandleWebhookResponse.perform(webhook_params)

    head (result.success? ? :ok : :internal_server_error)
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
      repo_full_name: payload.repository.full_name
    }
  end

end
