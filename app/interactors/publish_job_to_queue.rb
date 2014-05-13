class PublishJobToQueue
  include Interactor

  def perform
    Rails.logger.info "publishing to queue"
    Rails.logger.info context.inspect
    QueueService.publish({id: context[:pull_request_event], sha: context[:sha], repo_full_name: context[:repo_full_name]})
  end
end
