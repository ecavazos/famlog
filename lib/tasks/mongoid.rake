namespace :db do
#  desc 'Load the seed data from db/seeds.rb'
#  task :seed => :environment do
#    seed_file = File.join(Rails.root, 'db', 'seeds.rb')
#    #load(seed_file) if File.exist?(seed_file)
#  end

  desc 'Migrate messages'
  task :migrate do
    Message.all.each do |m|
      m.save
    end
  end
end

