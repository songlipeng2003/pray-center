module V1
  module Entities
    class Notification < Grape::Entity
      expose :id
      expose :type, documentation: { type: 'String', desc: '类型' }
      expose :content, documentation: { type: 'String', desc: '内容' }
      expose :target_type, documentation: { type: 'String', desc: '目标类型' }
      expose :target_id, documentation: { type: 'String', desc: '目标编号' }
      expose :created_at, documentation: { type: 'String', desc: '提醒时间' }
    end
  end
end
