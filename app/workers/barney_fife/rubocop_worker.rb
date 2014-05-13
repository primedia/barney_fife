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
      puts msg.inspect
      begin
        pr = PullRequestEvent.find_by_id(msg[:id])

        presenter = BarneyFife::Rubocop.run(pr)
        commenter = GitHub::Commenter.new(pr)

        files = presenter.json_output["files"]
        files.each do |file|
          file.offenses.each do |offense|
            create_comment(commenter, file, offense)
          end
        end

        status = GitHub::Status.new(pr.repo_full_name, pr.sha)

        presenter.success? ? status.success! : status.failure!

        OpenStruct.new('success?' => true)

      rescue StandardError => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")

        GitHub::Status.new(msg[:repo_full_name], msg[:sha]).error!

        OpenStruct.new('success?' => false)
      end
    end

    def create_comment(commenter, file, offense)
      commenter.create_line_comment(comment(file, offense))
    end

    def comment(file, offense)
      GitHub::Comment.new(path: relative_path(file['path']),
                          line_number: offense['location']['line'],
                          body: formatted_message(offense)
                         )
    end

    def relative_path(path)
      split_on_temp_path_regex = %r(tmp/rubocop.+/)
      path.split(split_on_temp_path_regex)[-1]
    end

    def formatted_message(offense)
      "#{offense['location']['line']}:#{offense['location']['column']} - #{offense['cop_name']} - #{offense['message']}"
    end
  end
end
