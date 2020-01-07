FactoryBot.define do
  factory :user do
    id { 1 }
    name { "テストユーザー１" }
    email { "testuser1@com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
end
