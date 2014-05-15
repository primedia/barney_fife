class PrepareRepository
  include Interactor

  def perform
    @name, @org = context.values_at(:name, :organization)
    g = Git::Commands.new(name: @name, organization: @org)
    _,_,status = if g.is_repo?
                   g.chdir(full_path) { g.pull }
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
