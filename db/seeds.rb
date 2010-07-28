Mongoid.database.collections.each do |c|
  c.drop unless c.name == 'system.indexes'
end

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

for i in 0...15
  Message.create({
    text: "This is message number #{i + 1}.",
    user: jack
  })

  puts "Added message #{i+1}"
end

for i in 0...20
  date = Date.today + 10 - i

  importance = i < 4 ? Importance::SUPER_HIGH : Importance::MEDIUM

  Message.create({
    title: "We have something to do on #{date}",
    text: "Don't miss this event. This is event number #{i + 1}",
    importance: importance,
    is_event: true,
    user: jill,
    start_at: date
  })

  puts "Added event #{i+1}"
end

