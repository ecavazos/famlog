Factory.define :message do |m|
  m.title "Test Message"
  m.created_at Time.now
end

Factory.define :user do |u|
  u.username "jack"
end
