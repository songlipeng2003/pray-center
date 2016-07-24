module V1
  module Entities
    class User < Grape::Entity
      expose :id
      expose :phone
      expose :created_at
    end
  end
end
