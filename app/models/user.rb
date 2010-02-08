class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username
  field :email
  field :first_name
  field :last_name

  # relationships
  has_many_related :messages
end
