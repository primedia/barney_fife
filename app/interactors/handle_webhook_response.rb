class HandleWebhookResponse
  include Interactor::Organizer

  organize NotifyPendingStatus, CreatePullRequestEvent, PublishJobToQueue
end
