module V1
  module Entities
    class Post < Grape::Entity
      expose :id
      expose :category_id
      expose :category_name do |post|
        post.category.name
      end
      expose :region_id
      expose :region_name do |post|
        post.region.name
      end
      expose :title
      expose :content
      expose :pray_number
      expose :created_at
    end
  end
end
