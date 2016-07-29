class PrayHistory < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :update_pray_number

  def update_pray_number
    post.pray_number = post.pray_histories.count
    post.save!
  end
end
