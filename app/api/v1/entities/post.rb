module V1
  module Entities
    class Post < Grape::Entity
      expose :id
      expose :category_id
      expose :title
      expose :content
      expose :created_at
    end
  end
end
