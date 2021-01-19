FactoryBot.define do
  factory :care_diary do
    association :user
    notes { "MyText" }
    temperature { 36.5 }
    date { "2021-01-09" }
    breakfast_meal_intake { 1 }
    lunch_meal_intake { 1 }
    dinner_meal_intake { 1 }
    name { "山田太郎" }
  end
end
