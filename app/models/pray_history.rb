class PrayHistory < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :update_pray_number, :create_notification, :update_user_score

  def update_pray_number
    post.pray_number = post.pray_histories.count
    post.save!
  end

  def create_notification
    notification = Notification.new
    notification.type = 'pray'
    notification.user = post.user
    notification.actor = user
    notification.target = post
    notification.content = "#{user.name}代祷了你的#{post.title}"
    notification.save!
  end

  def update_user_score
    user.increment(:score)
    user.save
  end
end
