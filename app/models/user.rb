class User < ApplicationRecord
  include Tokenable

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :lockable

  has_many :posts

  def email_required?
    false
  end

  def display_name
    phone
  end

  rails_admin do
  end
end
