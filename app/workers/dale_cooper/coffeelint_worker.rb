require 'ostruct'

module DaleCooper
  class CoffeelintWorker
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
      begin
        GenerateReport.perform(pull_request: PullRequestEvent.find_by_id(msg[:id]))
      rescue StandardError => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")

        GitHub::Status.new(msg[:repo_full_name], msg[:sha]).error!

        OpenStruct.new('success?' => false)
      end
    end
  end
end
