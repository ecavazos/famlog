class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text

  validates_presence_of :text

  belongs_to_related :user
  embedded_in :message, :inverse_of => :replies
end
