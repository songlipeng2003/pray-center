module V1
  module Entities
    class Region < Grape::Entity
      expose :id
      expose :name
    end
  end
end
