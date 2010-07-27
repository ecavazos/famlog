require 'ostruct'
require 'yaml'

yaml = YAML.load_file("#{Rails.root}/config/settings.yml")
settings = {}

yaml[Rails.env].each do |k, v|
  settings[k] = OpenStruct.new(v)
end

Famlog::Settings = OpenStruct.new(settings)
