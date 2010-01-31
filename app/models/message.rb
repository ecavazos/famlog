class Message
  include MongoMapper::Document

  key :title, String  # events have titles but messages do not

  key :start_date, Date
  key :end_date, Date
  key :message, String

  key :user_id, ObjectId
  key :username, String
  key :importance, String

  timestamps!

  # relationships
  belongs_to :user

end
