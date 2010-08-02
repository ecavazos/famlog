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
  Message.create({
    text: "This is message number #{i + 1}.",
    importance: Importance[i%4],
    user: jack
  })

end

for i in 0...20
  date = Date.today + 10 - i

  Message.create({
    title: "We have something to do on #{date}",
    text: "This is going to be an amazing event. Event number #{i + 1}",
    importance: Importance[i%4],
    is_event: true,
    user: jill,
    start_at: date
  })

end

