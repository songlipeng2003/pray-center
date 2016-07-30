module V1
  module Entities
    class Notification < Grape::Entity
      expose :id
      expose :content
      expose :target_type
      expose :target_id
      expose :created_at
    end
  end
end
