class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title # events have titles but messages do not
  field :message

  # TODO: these properties should be Dates but due to
  # this bug - http://github.com/durran/mongoid/issues#issue/53
  # I've made DateTimes as a workaround
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime

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
