class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :region

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :region, presence: true
end
