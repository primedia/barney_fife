class CreatePullRequestEvent
  include Interactor

  def perform
    pull_request_event = PullRequestEvent.create(owner: context[:owner], repo: context[:repo], pull_request_number: context[:pull_request_number], sha: context[:sha])

    if pull_request_event
      context[:pull_request_event] = pull_request_event.id
    else
      context.fail!
    end
  end

end
