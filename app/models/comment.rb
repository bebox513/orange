class Comment < ApplicationRecord
  validates :content, presence: true, length: { in: 1..255 }

  belongs_to :user
  belongs_to :post
end
