# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

jack = User.create({
  username: "jack",
  email: "jack@famlog.com",
  first_name: "Jack",
  last_name: "Move",
  password: "1234",
  password_confirmation: "1234"
})
puts "Added #{jack.email}"

jill = User.create({
  username: "jill",
  email: "jill@famlog.com",
  first_name: "Jill",
  last_name: "Move",
  password: "1234",
  password_confirmation: "1234"
})
puts "Added #{jill.email}"

puts 'Adding messages ...'

for i in 0..15
  Message.create({
    message: "This is message number #{i + 1}.",
    user: jack
  })
end

for i in 0..20
  date = Date.today + 10 - i

  Message.create({
    title: "We have something to do on #{date}",
    message: "Don't miss this event. This is event number #{i + 1}",
    importance: Importance::SUPER_HIGH,
    is_event: true,
    user: jill,
    start_at: date
  })
end
