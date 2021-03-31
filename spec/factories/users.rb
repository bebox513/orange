FactoryBot.define do
  factory :user do
    name { "山田太郎" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
    role { "1" }
  end
end

FactoryBot.define do
  factory :user2, class: User do
    name { "山田太郎" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
    role { "2" }
  end
end
