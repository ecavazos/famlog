class Message
  include MongoMapper::Document

  key :title, String
  key :date, Date
  key :message, String

  key :user_id, ObjectId
  key :username, String
  key :importnace, String

  timestamps!

  # relationships
  belongs_to :user

end
