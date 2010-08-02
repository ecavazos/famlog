class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable # , :validatable

  field :username
  field :first_name
  field :last_name

  # validations
  validates_uniqueness_of :username
  validates_presence_of :username, :first_name, :last_name

  # relationships
  referenced_in   :family
  references_many :messages
  references_many :replies

  named_scope :family_members, lambda { |user| where(:email.ne => user.email) }

  def owns?(entity)
    if entity.respond_to?(:user)
      return entity.user == self
    end
    false
  end

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
