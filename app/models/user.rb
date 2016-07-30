class User < ApplicationRecord
  include Tokenable

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :lockable

  has_many :posts
  has_many :pray_histories
  has_many :notifications

  has_many :favorites, class_name: 'FavoriteUser', source: :user
  has_many :favoriteds, class_name: 'FavoriteUser', source: :favorited_user
  has_many :favorite_users, through: :favorites, class_name: 'User', source: :favorited_user
  has_many :favorited_users, through: :favoriteds, class_name: 'User', source: :user

  def email_required?
    false
  end

  def display_name
    phone
  end

  rails_admin do
  end
end
