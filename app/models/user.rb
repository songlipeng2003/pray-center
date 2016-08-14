class User < ApplicationRecord
  include Tokenable

  STATUS_UNAPPLYED = 0;
  STATUS_PENDING = 1;
  STATUS_CHECKED = 2;
  STATUS_REFUSED = -1;

  STATUSES = {
    STATUS_UNAPPLYED => '未申请',
    STATUS_PENDING => '待审核',
    STATUS_CHECKED => '已审核',
    STATUS_REFUSED => '已拒绝',
  }

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :lockable

  belongs_to :parent, class_name: 'User'

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

  scope :online, -> { where("online_at > ?", 1.hours.ago) }

  mount_uploader :avatar, AvatarUploader

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

  def status_text
    STATUSES[status]
  end
end
