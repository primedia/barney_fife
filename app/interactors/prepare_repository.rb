class PrepareRepository
  include Interactor

  def perform
    @name = context.fetch(:name) { context[:pull_request][:repo] }
    @org = context.fetch(:organization){ context[:pull_request][:owner] }
    g = Git::Commands.new(name: @name, organization: @org)

    _,_,status = if g.is_repo?
                   g.chdir(full_path) do
                     # TODO: git checkout correct branch
                     g.checkout('pr_test')
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
