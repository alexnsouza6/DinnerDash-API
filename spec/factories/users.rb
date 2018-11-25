FactoryBot.define do
  factory :user do
    name { "Alex" }
    username { "Xela" }
    email { "123@email.com" }
    password { "123123" }
    password_confirmation { "123123" }
  end
end
