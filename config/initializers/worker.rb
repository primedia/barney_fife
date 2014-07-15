if Rails.configuration.worker && !ENV['UNICORN_WORKER_PROCESSES']
  Thread.new do
    BarneyFife::RubocopWorker.run
    DaleCooper::CoffeelintWorker.run
  end
end
