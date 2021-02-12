FactoryBot.define do
  factory :post do
    content { "MyText" }
    association :user
  end
end
