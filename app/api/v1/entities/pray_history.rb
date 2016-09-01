module V1
  module Entities
    class PrayHistory < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: '代祷编号' }
      expose :user_id, documentation: { type: 'Integer', desc: '用户编号' }
      expose :user_name, documentation: { type: 'String', desc: '用户名称' } do |instance|
        instance.user.name
      end
      expose :user_avatar, documentation: { type: 'String', desc: '用户名称' } do |instance|
        instance.user.avatar.thumb.url
      end
      expose :is_thanked, documentation: { type: 'Boolean', desc: '是否已经感谢' }
      expose :created_at, documentation: { type: 'String', desc: '代祷时间' }
    end
  end
end
