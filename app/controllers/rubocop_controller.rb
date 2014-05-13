class RubocopController < ApplicationController

  def hook
    pr = PullRequestHook.new(params['payload'])
    # TODO: turn pr object into something that can to_hash & splat into place for later calls
    QueueService.publish(pr.to_hash)

    render json: pr.to_hash
  end
end
