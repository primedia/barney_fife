module GitHub
  class Commenter
    attr_reader :pull_request

    def intialize(pull_request)
      @pull_request = pull_request
    end

    def create_line_comment(path: path, line_number: line_number, body: body)
      GitHub::Client.create_pull_request_comment(
        pull_request.repo_full_name,
        pull_request.pull_request_number,
        body,
        pull_request.sha,
        path,
        line_number
      )
    end

  end
end
