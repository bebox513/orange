class CareRecipient < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { in: 1..10 }
  validates :sex, presence: true
  validates :birthday, presence: true
  validates :age, presence: true, numericality: { only_integer: true }
  validates :facility_in_charge, length: { in: 1..50 }, allow_blank: true
  validates :manager_in_charge, length: { in: 1..10 }, allow_blank: true
  validates :degree_care_required, presence: true, numericality: { only_integer: true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
  validates :dementia, presence: true
  validates :notes, length: { in: 1..255 }

  enum sex: { 男: 1, 女: 2 }
  enum dementia: { 有り: 1, 無し: 2 }


end
