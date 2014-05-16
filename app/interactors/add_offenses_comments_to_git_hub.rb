class AddOffensesCommentsToGitHub
  include Interactor

  def setup
    @commenter = GitHub::Commenter.new(context[:pull_request])
  end

  def perform
    Array(context[:offenses]).each do |offense|
      comment(offense)
    end
  end

  private

  def comment(offense)
    path_in_repo = path_relative_to_repo(offense.path)
    @commenter.create_line_comment(path: path_in_repo, line_number: offense.line_number, body: offense.formatted_message)
  end

  def path_relative_to_repo(path)
    full_name = @commenter.pull_request.repo_full_name
    path.split(%r(#{Regexp.escape(full_name)}/)).last
  end
end
