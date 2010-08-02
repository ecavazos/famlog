Mongoid.database.collections.each do |c|
  c.drop unless c.name == 'system.indexes'
end

move_fam = Family.create({
  name: 'Move'
})

jack = User.create({
  username: 'jack',
  email: 'jack@famlog.com',
  first_name: 'Jack',
  last_name: 'Move',
  password: '1234',
  password_confirmation: '1234',
  family: move_fam
})

jill = User.create({
  username: 'jill',
  email: 'jill@famlog.com',
  first_name: 'Jill',
  last_name: 'Move',
  password: '1234',
  password_confirmation: '1234',
  family: move_fam
})

for i in 0...10
  case i % 4
  when 0
    importance = Importance::LOW
  when 1
    importance = Importance::MEDIUM
  when 2
    importance = Importance::HIGH
  when 3
    importance = Importance::SUPER_HIGH
  else
    importance = Importance::LOW
  end

  Message.create({
    text: "This is message number #{i + 1}.",
    importance: importance,
    user: jack
  })

end

for i in 0...20
  date = Date.today + 10 - i

  case i % 4
  when 0
    importance = Importance::LOW
  when 1
    importance = Importance::MEDIUM
  when 2
    importance = Importance::HIGH
  when 3
    importance = Importance::SUPER_HIGH
  else
    importance = Importance::LOW
  end

  Message.create({
    title: "We have something to do on #{date}",
    text: "This is going to be an amazing event. Event number #{i + 1}",
    importance: importance,
    is_event: true,
    user: jill,
    start_at: date
  })

end

