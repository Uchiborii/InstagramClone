500.times do |n|
  name = Faker::User.name
  email = Faker::User.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end