module NotificationAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        field :user
        field :type
        field :content
        field :created_at
      end
    end
  end
end
