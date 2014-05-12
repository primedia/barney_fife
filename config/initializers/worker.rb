if Rails.configuration.worker && !ENV['UNICORN_WORKER_PROCESSES']
  Thread.new do
    RubocopWorker.run
  end
end
