class PrepareRepository
  include Interactor

  def perform
    @name = context[:name] || context[:pull_request][:repo]
    @org = context[:organization] || context[:pull_request][:owner]
    @ref = context[:ref] || context[:pull_request][:ref] || 'master'
    g = Git::Commands.new(name: @name, organization: @org)

    _,_,status = if g.is_repo?
                   g.chdir(full_path) do
                     g.checkout_default_branch
                     g.fetch_all
                     g.checkout(@ref)
                     g.pull
                   end
                 else
                   g.chdir { g.clone }
                 end

    context.fail! if status_failed?(status)
  end

  def status_failed?(status)
    status.exitstatus != 0
  end

  def full_path
    "#{Rails.configuration.repo_dir}#{@org}/#{@name}"
  end
end
