require 'ostruct'

module BarneyFife
  class RubocopWorker
    attr_reader :queue_service

    def self.run
      new.run
    end

    def initialize(queue_service = ::QueueService)
      @queue_service = queue_service
    end

    def run
      queue_service.consume { |msg| process(msg) }
    end

    private

    def process(msg)
      pr = PullRequestEvent.find_by_id(msg)

      presenter = BarneyFife::Rubocop.run(pull_request_number: pr.pull_request_number, owner: pr.owner, repo: pr.repo)

      commenter = BarneyFife::Rubocop::Comment.new(issue_number: pr.pull_request_number,
                                    owner: pr.owner,
                                    repo: pr.repo,
                                    content: '')

      collection = BarneyFife::Rubocop::OffenseCollection.new(json: presenter.json_output["files"])
      collection.files.each do |file|
        file.issues.each do |offense|
          commenter.create_on_line(sha: pr.sha,
                                  path: file.relative_path,
                                  line_number: offense.location.line,
                                  body: offense.body)
        end
      end

      status = GitHub::Status.new(pr.repo_full_name, pr.sha)

      presenter.success? ? status.success! : status.failure!

      OpenStruct.new('success?' => true)
    end
  end
end
