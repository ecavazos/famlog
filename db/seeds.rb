if Rails.env == 'production'

  User.create({
    username: 'ecni',
    email: 'ejcavazos@gmail.com',
    first_name: 'Emilio',
    last_name: 'Cavazos',
    password: 'emilio',
    password_confirmation: 'emilio'
  })

  User.create({
    username: 'josie',
    email: 'jmorris22734@gmail.com',
    first_name: 'Josie',
    last_name: 'Cavazos',
    password: 'josie',
    password_confirmation: 'josie'
  })

else

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

    Message.create({
      title: "We have something to do on #{date}",
      text: "Don't miss this event. This is event number #{i + 1}",
      importance: Importance::SUPER_HIGH,
      is_event: true,
      user: jill,
      start_at: date
    })

    puts "Added event #{i+1}"
  end

end
