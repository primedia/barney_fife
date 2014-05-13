class NotifyPendingStatus
  include Interactor

  def perform
    GitHub::Status.new(context[:repo_full_name], context[:sha]).pending!
  end

  def rollback
    GitHub::Status.new(context[:repo_full_name], context[:sha]).error!
  end
end
