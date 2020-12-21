class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, length: { in: 1..50 }
  validates :password, presence: true, on: :create, length: { in: 5..10 }
  validates :name, presence: true, length: { in: 1..10 }

  has_many :messages, dependent: :destroy

  has_many :entries, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_one_attached :avatar

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def update_with_password(params)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params)
    clean_up_passwords
    result
  end

end
