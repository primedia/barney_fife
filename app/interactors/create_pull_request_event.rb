class CreatePullRequestEvent
  include Interactor

  def perform
    pull_request_event = PullRequestEvent.new(owner: context[:owner], repo: context[:repo], pull_request_number: context[:pull_request_number], sha: context[:sha], ref: context[:ref])

    if pull_request_event.save
      context[:pull_request_event] = pull_request_event.id
    else
      context.fail!
    end
  end

end
