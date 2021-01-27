FactoryBot.define do
  factory :care_recipient do
    association :user
    name { "山田太郎" }
    sex { 1 }
    birthday { "2021-01-20" }
    age { 1 }
    facility_in_charge { "MyString" }
    manager_in_charge { "MyString" }
    degree_care_required { 1 }
    dementia { 1 }
    notes { "MyText" }
  end
end
