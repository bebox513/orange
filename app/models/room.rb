class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, presence: true, length: { in: 1..10 }
end
