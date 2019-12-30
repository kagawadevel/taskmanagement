10.times do |n|
  name = Faker::Games::Pokemon.name
  User.create!(name: name,
               email: "email#{n}",
               password: 'password',
               password_confirmation: 'password'
               )
end