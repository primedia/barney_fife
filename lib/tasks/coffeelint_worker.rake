namespace :worker do
  task coffeelint: :environment do
    DaleCooper::CoffeelintWorker.run
  end
end
