module GitHub
  class Commenter
    attr_reader :pull_request

    def intialize(pull_request)
      @pull_request = pull_request
    end

    def create_line_comment(comment)
      GitHub::Client.create_pull_request_comment(
        pull_request.repo_full_name,
        pull_request.pull_request_number,
        comment.body,
        pull_request.sha,
        comment.path,
        comment.line_number
      )
    end

  end
end
