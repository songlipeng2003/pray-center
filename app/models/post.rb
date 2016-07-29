class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :region

  has_many :pray_histories

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :region, presence: true
end
