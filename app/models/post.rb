class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :region

  has_many :pray_histories

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :region, presence: true

  validate :speed_limit, on: :create

  scope :today, -> { where("created_at > ?", Date.today) }

  def speed_limit
    if user.posts.today.count>2
      errors.add(:title, '今天发帖量已经达到最大限制')
    end
  end
end
