FactoryBot.define do
  factory :comment do
    content { "MyText" }
    association :user
    association :post
  end
end
