require 'uri'


File.open(File.join(Rails.root, 'config/database.mongo.yml'), 'r') do |f|
  if ENV['MONGOHQ_URL']
    mongo_uri = URI.parse(ENV['MONGOHQ_URL'])
    puts mongo_uri
    @settings = {}
    @settings['host'] = mongo_uri.host
    @settings['port'] = mongo_uri.port.to_s
    @settings['username'] = mongo_uri.user
    @settings['password'] = mongo_uri.password
    @settings['database'] = mongo_uri.path.gsub('/', '')
  else
    @settings = YAML.load(f)[Rails.env]
  end
end

connection = Mongo::Connection.new(@settings["host"])
Mongoid.database = connection.db(@settings["database"])

if @settings["username"]
  Mongoid.database.authenticate(@settings["username"], @settings["password"])
end

