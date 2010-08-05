Factory.define :message do |x|
  x.title "Test Message"
  x.created_at Time.now
end

Factory.define :user do |x|
  x.username   "jack"
  x.first_name "Jack"
  x.last_name  "Move"
  x.association :family
end

Factory.define :family do |x|
  x.name "Move"
end
