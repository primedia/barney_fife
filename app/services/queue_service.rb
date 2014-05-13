class QueueService
  attr_reader :queue_name

  def self.consume(&block)
    queue_service.consume(block)
  end

  def self.publish(msg)
    queue_service.publish(msg.to_s)
  end

  def self.queue_service
    @queue_service ||= new
  end

  def initialize(queue_name = Rails.configuration.worker_queue)
    @queue_name = queue_name
  end

  def consume(block)
    queue.subscribe(ack: true, block: false) do |delivery_info, properties, body|
      tag = delivery_info.delivery_tag
      result = block.call(body)
      result.success? ? acknowledge_message(tag) : reject_message(tag)
    end
  end

  def publish(msg)
    queue.publish(msg, persistent: true, routing_key: queue.name)
  end

  private

  def channel
    @channel ||= $rabbitmq_channel
  end

  def queue
    @queue ||= channel.queue(queue_name, durable: true)
  end

  def acknowledge_message(tag)
    channel.ack(tag, false)
  end

  def reject_message(tag)
    channel.reject(tag, true)
  end
end
