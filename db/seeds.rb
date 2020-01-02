10.times do |n|
  name = Faker::Games::Pokemon.name
  User.create!(name: name,
               email: "email#{n}",
               password: 'password',
               password_confirmation: 'password'
  )
end

User.create!(name: "管理者権限ユーザー",
              email: "kanrisyakengen@com",
              password: "password",
              password_confirmation: "password",
              admin: true
)