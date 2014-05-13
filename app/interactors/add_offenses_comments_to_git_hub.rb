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
    @commenter.create_line_comment(path: offense.relative_path, line_number: offense.line_number, body: offense.formatted_message)
  end
end
