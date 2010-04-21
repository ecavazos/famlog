# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#

jack = User.create({
  username: "jack",
  email: "jack@famlog.com",
  first_name: "Jack",
  last_name: "Move",
  password: "1234",
  password_confirmation: "1234"
})

jill = User.create({
  username: "jill",
  email: "jill@famlog.com",
  first_name: "Jill",
  last_name: "Move",
  password: "1234",
  password_confirmation: "1234"
})

Message.create({
  message: "First message ...",
  user: jack,
  username: jack.username
})

Message.create({
  title: "First Event",
  message: "Don't miss the first event ever.",
  importance: Importance::SUPER_HIGH,
  is_event: true,
  user: jill,
  username: jill.username,
  start_date: Date.today
})

