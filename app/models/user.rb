class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username
  field :email
  field :encrypted_password
  field :password_salt
  field :first_name
  field :last_name

  attr_accessor :password, :password_confirmation

  before_save :initialize_salt, :encrypt_password

  # relationships
  has_many_related :messages
  
  attr_accessor :password, :password_confirmation
  
  class << self
    def authenticate(username, password)
      by_username = {:conditions => {:username => username}}
      by_email = {:conditions => {:email => username}}
      return nil unless user = first(by_username) || first(by_email)
      user if user.authenticated?(password)
    end
  end
  
  def authenticated?(password)
    encrypted_password == encrypt(password)
  end
  
  private

  def encrypt_password
    self.encrypted_password = encrypt(password)
  end

  def generate_hash(string)
    Digest::SHA1.hexdigest(string)
  end

  def initialize_salt
    if new_record?
      self.password_salt = generate_hash("--#{Time.now.utc}--#{password}--")
    end
  end

  def encrypt(string)
    generate_hash("--#{password_salt}--#{string}--")
  end

end
