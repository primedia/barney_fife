ENV_CONFIG = '/etc/rentpath/environment.cfg'

def parse_cfg(file_name)
  File.open(file_name) do |f|
    f.each_line do |line|
      next if line['='].nil? || line.strip.start_with?('#')
      k, v = line.strip.split('=')
      ENV[k.upcase] = v.gsub(/\"/, '').to_s
    end
  end
end

if File.readable?(ENV_CONFIG)
  parse_cfg(ENV_CONFIG)
else
  raise LoadError, "#{ENV_CONFIG} could not be read."
end

#########################
# Unicorn Configuration #
#########################

worker_processes ENV['UNICORN_WORKER_PROCESSES'].to_i

working_directory "#{ENV['APPLICATIONS_HOMEBASE_ROOT']}/current"

listen ENV['UNICORN_LISTENING_PORT'].to_i, tcp_nopush: !!ENV['UNICORN_TCP_NOPUSH'].downcase.match(/true/)

timeout ENV['UNICORN_TIMEOUT'].to_i

pid File.join(ENV['APPLICATIONS_HOMEBASE_ROOT'], ENV['UNICORN_PID_LOCATION'])

stderr_path File.join(ENV['APPLICATIONS_HOMEBASE_ROOT'], ENV['UNICORN_STDERR_PATH'])
stdout_path File.join(ENV['APPLICATIONS_HOMEBASE_ROOT'], ENV['UNICORN_STDOUT_PATH'])

preload_app true

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)

  require 'bunny'
  $rabbitmq_connection = Bunny.new(host: ENV['DATASTORES_RABBITMQ_HOST']).tap { |conn| conn.start }

  $rabbitmq_channel = $rabbitmq_connection.create_channel.tap { |ch| ch.default_exchange; ch.prefetch(1) }

  Thread.new do
    BarneyFife::RubocopWorker.run
    DaleCooper::CoffeelintWorker.run
  end

end
