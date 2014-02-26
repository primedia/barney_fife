class RubocopController < ApplicationController

  def hook
    pr = PullRequestHook.new(params['payload'])
    @presenter = BarneyFife::Rubocop.run(issue_number: pr.pr_number, owner: pr.owner, repo: pr.repo)
    logger.info "RubocopController#hook -- #{@presenter}"
    # paste comments back to GH using @presenter
    render json: @presenter.json_output
  end
end
