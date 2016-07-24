class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :lockable

  def email_required?
    false
  end

  def display_name
    phone
  end

  rails_admin do
  end
end
