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
      expose :area, documentation: { type: 'String', desc: '代祷区域' }
      expose :period, documentation: { type: 'Integer', desc: '祷告时间段，1、2、3、4' }
      expose :created_at, documentation: { type: 'String', desc: '注册时间' }
      expose :invitation_code, documentation: { type: 'String', desc: '邀请码' }
    end
  end
end
