class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  field :username
  field :first_name
  field :last_name

  # relationships
  has_many_related :messages

  class << self

    # find user by email or username
    def find_for_database_authentication(conditions)
      user = find(:first, :conditions => conditions)
      if user.nil?
        find(:first, :conditions => { :username => conditions[:email] })
      else
        user
      end
    end
  end
end
