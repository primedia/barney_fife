require 'ostruct'

class RubocopWorker
  attr_reader :searcher, :queue_service

  def self.run
    new.run
  end

  def initialize(queue_service = QueueService)
    @queue_service = queue_service
  end

  def run
    queue_service.consume do |msg|
      sleep 2
      puts msg.class
      # job = SearchJob.find_or_create_by!(search_criteria_id: search_criteria_id)
      # begin
      #   result = search(search_criteria_id)
      #   notify_client(search_criteria_id) if result
      OpenStruct.new('success?' => true)
      # rescue ActiveRecord::RecordNotFound
      #   OpenStruct.new('success?' => true)
      # end
    end
  end

  private

  # def notify_client(search_criteria_id, event = 'search-criteria-ready')
  #   channel = "private-#{search_criteria_id}"
  #   puts "publishing to #{channel}"
  #   Pusher.trigger(channel, event, {
  #     message: 'hello world'
  #   })
  # end

  # def search(id)
  #   searcher.search(id)
  # end
end
