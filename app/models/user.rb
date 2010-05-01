class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  field :username
  field :first_name
  field :last_name

  attr_accessor :username, :email, :password, :password_confirmation

  # relationships
  has_many_related :messages

end
