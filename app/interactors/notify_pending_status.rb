class NotifyPendingStatus
  include Interactor

  def perform
    Rails.logger.info "Notifying pending status"
    Rails.logger.info context.inspect
    GitHub::Status.new(context[:repo_full_name], context[:sha]).pending!
  end

  def rollback
    GitHub::Status.new(context[:repo_full_name], context[:sha]).error!
  end
end
