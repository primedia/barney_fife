class PullRequestEvent < ActiveRecord::Base
  def repo_full_name
    "#{owner}/#{repo}"
  end
end
