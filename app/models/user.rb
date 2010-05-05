class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  field :first_name
  field :last_name

  # relationships
  has_many_related :messages

end
