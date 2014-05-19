if Rails.configuration.worker && !ENV['UNICORN_WORKER_PROCESSES']
  Thread.new do
    BarneyFife::RubocopWorker.run
  end
end
