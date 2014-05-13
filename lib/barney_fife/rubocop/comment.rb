module BarneyFife
  module Rubocop
    class Comment
      attr_accessor :response
      include Anima.new(:issue_number, :owner, :repo, :content)

      def api_post
        @api ||= Faraday.new 'https://api.github.com' do |conn|
          conn.use Faraday::Request::BasicAuthentication, ENV['GITHUB_AUTH_TOKEN'], 'x-oauth-basic'
          conn.request :json
          conn.response :json, :content_type => /\bjson$/
          conn.use :instrumentation
          conn.adapter Faraday.default_adapter
          @logger = Logger.new(STDOUT)
          @logger.level = Logger::DEBUG
        end
      end

      def create_on_pr
        # POST /repos/primedia/barney_fife/issues/1/comments -d {"body": "a new comment"}
        api_post.post do |req|
          req.url "/repos/#{owner}/#{repo}/issues/#{issue_number}/comments"
          req.headers['Content-Type'] = 'application/json'
          req.body = { "body" => "#{content}" }.to_json
        end
      end

      def create_on_line(sha: sha, path: path, line_number: line_number, body: body)
        # https://developer.github.com/v3/pulls/comments/#create-a-comment
        # Create a comment
        #
        # POST /repos/:owner/:repo/pulls/:number/comments
        # Input
        #
        # Name	Type	Description
        # body	string	Required. The text of the comment
        # commit_id	string	Required. The SHA of the commit to comment on.
        # path	string	Required. The relative path of the file to comment on.
        # position	number	Required. The line index in the diff to comment on.
        # Example
        # {
        #   "body": "Nice change",
        #   "commit_id": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
        #   "path": "file1.txt",
        #   "position": 4
        # }
        # sha = "9caf57305a1c83a351aa7a2838b892a79b562b4b"
        # path = "pr_test.rb"
        # line_number = "3"
        # SHA can come from json payload pull_request => head => sha
        payload = {
          body: body,
          commit_id: sha,
          path: path,
          position: line_number,
        }

        api_post.post do |req|
          req.url "/repos/#{owner}/#{repo}/pulls/#{issue_number}/comments"
          req.headers['Content-Type'] = 'application/json'
          req.body = payload.to_json
        end
      end

    end
  end
end
