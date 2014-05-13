class PublishJobToQueue
  include Interactor

  def perform
    Rails.logger.info "publishing to queue"
    Rails.logger.info context.inspect
    QueueService.publish(context[:pull_request_event])
  end
end
