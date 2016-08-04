class User < ApplicationRecord
  include Tokenable

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :lockable

  has_one :parent, class_name: 'User'

  has_many :posts
  has_many :pray_histories
  has_many :notifications

  has_many :favorites, class_name: 'FavoriteUser', source: :user
  has_many :favoriteds, class_name: 'FavoriteUser', source: :favorited_user
  has_many :favorite_users, through: :favorites, class_name: 'User', source: :favorited_user
  has_many :favorited_users, through: :favoriteds, class_name: 'User', source: :user

  validates :phone, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z][a-z0-9_]{4,16}[a-z0-9]\z/,
    message: "第一位必须应为字母，只能小写英文、数字和_的组合，长度6-18位" }

  def email_required?
    false
  end

  def display_name
    phone
  end

  def invitation_code
    (id * 1000 + 1000000).to_s(16)
  end

  def User.encode_invitation_code(code)
    (code.hex - 1000000) / 1000
  end
end
