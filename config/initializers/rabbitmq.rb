unless ENV['UNICORN_WORKER_PROCESSES']
  $rabbitmq_connection = Bunny.new(host: (ENV['DATASTORES_RABBITMQ_HOST'] || 'localhost')).tap { |conn| conn.start }

  $rabbitmq_channel = $rabbitmq_connection.create_channel.tap { |ch| ch.default_exchange; ch.prefetch(1) }
end
