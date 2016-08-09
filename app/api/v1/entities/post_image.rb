module V1
  module Entities
    class PostImage < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: '编号' }
      expose :image, documentation: { type: 'String', desc: '图片' } do |instance|
        instance.image.thumb.url
      end
    end
  end
end
