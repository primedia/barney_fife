module GitHub
  class Commenter
    attr_reader :pull_request, :repo_full_name, :pull_request_number

    def initialize(pull_request)
      @pull_request = pull_request
      @repo_full_name = pull_request.repo_full_name
      @pull_request_number = pull_request.pull_request_number
    end

    def create_line_comment(path: path, line_number: line_number, body: body)
      return if comment_exists?(path, line_number, body)
      GitHub::Client.create_pull_request_comment(
        repo_full_name,
        pull_request_number,
        body,
        pull_request.sha,
        path,
        line_number
      )
    end

    def comment_exists?(path, line_number, body)
      matching_comments = existing_comments.select do |i|
        (i.path == path) &&
        (i.position == line_number) &&
        (i.body == body)
      end

      matching_comments.present?
    rescue
      false
    end


    def existing_comments
      @existing_comments ||= GitHub::Client.pull_request_comments(repo_full_name, pull_request_number)
    end

    def existing_comment_bodies
      @existing_comment_bodies ||= @existing_comments.map { |i| i.body }
    end

  end
end
