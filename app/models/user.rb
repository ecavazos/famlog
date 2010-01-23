class User
  include MongoMapper::Document

  key :username, String
  key :email, String
  key :first_name, String
  key :last_name, String

  timestamps!

  # relationships
  many :messages
end
