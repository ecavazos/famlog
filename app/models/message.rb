class Poop
  include Mongoid::Document
  
  field :name, :default => "Shit"
end

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title # events have titles but messages do not
  field :message
  field :start_date, :type => Date
  field :end_date, :type => Date
  field :is_event, :type => Boolean, :default => false
  field :importance, :default => Importance::LOW

  field :user_id
  field :username

  # relationships
  belongs_to_related :user

  def set_user(user)
    self.user = user
    self.username = user.username
  end

end
