class Family
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  references_many :users
end
