class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, length: { in: 1..50 }
  validates :password, presence: true, length: { in: 5..10 }
  validates :name, presence: true, length: { in: 1..10 }

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

end
