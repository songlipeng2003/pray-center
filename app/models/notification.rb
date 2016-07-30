class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: User

  belongs_to :target, polymorphic: true
  belongs_to :second_target, polymorphic: true

  validates :content, presence: true
  validates :type, presence: true
  validates :user, presence: true
end
