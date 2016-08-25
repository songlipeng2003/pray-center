module V1
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: '编号' }
      expose :avatar, documentation: { type: 'String', desc: '头像' } do |user|
        user.avatar.thumb.url
      end
      expose :username, documentation: { type: 'String', desc: '用户名' }
      expose :phone, documentation: { type: 'String', desc: '手机号' }
      expose :name, documentation: { type: 'String', desc: '姓名' }
      expose :address, documentation: { type: 'String', desc: '地址' }
      expose :gender, documentation: { type: 'String', desc: '性别，男或女' }
      expose :birth, documentation: { type: 'String', desc: '生日' }
      expose :education, documentation: { type: 'String', desc: '学历' }
      expose :job, documentation: { type: 'String', desc: '职业' }
      expose :church, documentation: { type: 'String', desc: '教会' }
      expose :church_service, documentation: { type: 'String', desc: '教会服侍' }
      expose :rebirth, documentation: { type: 'String', desc: '受洗时间' }
      expose :region_id, documentation: { type: 'Integer', desc: '代祷区域' }
      expose :region_name, documentation: { type: 'String', desc: '代祷区域' } do |instance|
        instance.region ? instance.region.name : nil
      end
      expose :period, documentation: { type: 'Integer', desc: '祷告时间段' }
      expose :period_text, documentation: { type: 'String', desc: '祷告时间段文字' }
      expose :created_at, documentation: { type: 'String', desc: '注册时间' }
      expose :invitation_code, documentation: { type: 'String', desc: '邀请码' }
      expose :status, documentation: { type: 'Integer', desc: '状态，0为未申请，1为申请中，2为已审核，-1为已拒绝' }
    end
  end
end
