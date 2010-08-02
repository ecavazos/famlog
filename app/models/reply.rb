class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text

  validates_presence_of :text

  referenced_in :user
  embedded_in   :message, :inverse_of => :replies
end
