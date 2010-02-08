# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#

ecni = User.create({
  username: "ecni",
  email: "ejcavazos@gmail.com",
  first_name: "Emilio",
  last_name: "Cavazos"
})

Message.create({
  message: "First message ...",
  user: ecni,
  username: ecni.username
})

Message.create({
  title: "First Event",
  message: "Don't miss the first event ever.",
  importance: Importance::SUPER_HIGH,
  is_event: true,
  user: ecni,
  username: ecni.username,
  start_date: Date.today
})

