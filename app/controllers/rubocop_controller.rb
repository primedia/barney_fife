class RubocopController < ApplicationController

  def hook
    pr = PullRequestHook.new(params['payload'])
    # TODO: turn pr object into something that can to_hash & splat into place for later calls
    # presenter = BarneyFife::Rubocop.run(issue_number: pr.pr_number, owner: pr.owner, repo: pr.repo)
    puts pr.to_hash
    QueueService.publish(pr.to_hash)
    # pr.comment = presenter.human_output
    # BarneyFife::Rubocop::Comment.new(issue_number: pr.pr_number, owner: pr.owner, repo: pr.repo, content: pr.comment).create_on_pr
    render json: pr.to_hash
  end
end
