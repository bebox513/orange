class Post < ApplicationRecord
  validates :content, presence: true,  length: { in: 1..500 }

  belongs_to :user

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_many :comments
  has_many :comment_posts, through: :comments, source: :user
end
