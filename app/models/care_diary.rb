class CareDiary < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { in: 1..10 }
  validates :date, presence: true
  validates :temperature, presence: true
  validates :breakfast_meal_intake, presence: true, numericality: { only_integer: true, less_than:11}
  validates :lunch_meal_intake, presence: true, numericality: { only_integer: true, less_than:11}
  validates :dinner_meal_intake, presence: true, numericality: { only_integer: true, less_than:11}
  validates :notes, presence: true,  length: { in: 1..255 }
  validates :user_id, presence: true
end
