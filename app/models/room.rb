class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, length: { in: 0..10 }, allow_blank: true
end
