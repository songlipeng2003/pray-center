module V1
  module Entities
    class User < Grape::Entity
      expose :id
      expose :phone
      expose :name
      expose :address
      expose :gender
      expose :birth
      expose :education
      expose :job
      expose :church
      expose :church_service
      expose :rebirth
      expose :area
      expose :period
      expose :created_at
    end
  end
end
