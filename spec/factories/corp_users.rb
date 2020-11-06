FactoryBot.define do
  factory :corp_user do
    name { "山田太郎" }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "password" }
    password_confirmation { 'password' }
  end
end
