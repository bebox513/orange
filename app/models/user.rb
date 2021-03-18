class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, length: { in: 1..50 }
  validates :password, presence: true, on: :create, length: { in: 5..10 }
  validates :name, presence: true, length: { in: 1..10 }
  validates :company, length: { in: 0..10 }, allow_blank: true
  validates :role, presence: true, numericality: { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }
  validates :text, length: { in: 0..500 }, allow_blank: true

  has_many :messages, dependent: :destroy

  has_many :entries, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  has_many :care_diaries, dependent: :destroy

  has_many :care_recipients, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :comment, dependent: :destroy

  has_one_attached :avatar

  def avatar_resize
    return self.avatar.variant(combine_options:{gravity: :center, resize:"190x190^", crop:"190x190+0+0"}).processed
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def liked_by?(post)
    self.likes.exists?(post_id: post.id)
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

  def self.guest(role)
    find_or_create_by!(name: 'ゲストユーザ', email: SecureRandom.urlsafe_base64(5) + '@example.com', role: role) do |user|
      user.password = SecureRandom.urlsafe_base64(7)
    end
  end
end
