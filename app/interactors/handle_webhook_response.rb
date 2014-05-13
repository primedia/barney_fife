class HandleWebhookResponse
  include Interactor::Organizer

  def setup
    Rails.logger.info '##########################'
    Rails.logger.info 'organizer setup'
    Rails.logger.info '##########################'
    Rails.logger.info context.inspect
  end

  organize NotifyPendingStatus, CreatePullRequestEvent, PublishJobToQueue
end
