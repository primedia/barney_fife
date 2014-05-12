namespace :worker do
  task rubocop: :environment do
    RubocopWorker.run
  end
end
