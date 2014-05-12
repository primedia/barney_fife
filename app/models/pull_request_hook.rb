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

  def to_hash
    [:repo_full, :owner, :repo, :pr_number].each_with_object({}) do |sym, obj|
      obj[sym] = send(sym)
    end
  end
end
