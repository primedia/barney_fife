namespace :worker do
  task rubocop: :environment do
    BarneyFife::RubocopWorker.run
  end
end
