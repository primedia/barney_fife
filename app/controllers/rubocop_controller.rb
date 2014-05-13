class RubocopController < ApplicationController

  def hook
    pr = PullRequestHook.new(params)
    # TODO: turn pr object into something that can to_hash & splat into place for later calls
    status = BarneyFife::Rubocop::Status.new(pr.repo_full, pr.sha)
    status.pending
    QueueService.publish(pr.to_hash)

    ## status.success || status.failure
    render json: pr.to_hash

  end
end
