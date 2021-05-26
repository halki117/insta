puts 'Start inserting seed "users" ...'
10.times do
  user = User.create(
      email: Faker::Internet.unique.email,
      name: Faker::Internet.unique.user_name,
      password: 'password',
      password_confirmation: 'password'
      )
  puts "\"#{user.name}\" has created!"
end