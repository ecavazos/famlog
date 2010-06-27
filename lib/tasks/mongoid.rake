namespace :db do
#  desc 'Load the seed data from db/seeds.rb'
#  task :seed => :environment do
#    seed_file = File.join(Rails.root, 'db', 'seeds.rb')
#    #load(seed_file) if File.exist?(seed_file)
#  end

  desc 'Migrate message property to text property'
  task :migrate do
    Message.all.each do |m|
      m.text = m.message
      m.message = nil
      m.instance_eval { @attributes.delete('message') }
      m.save
    end
  end
end

