class PullRequestHook < Webhook
  attr_accessor :data, :comment

  def initialize(json)
    @data = Hashie::Mash.new(json)
  end

  def repo_full
    data.pull_request.base.repo.full_name
  end

  def owner
    data.pull_request.base.repo.owner.login
  end

  def repo
    data.pull_request.base.repo.name
  end

  def pr_number
    data.number.to_s
  end
end
