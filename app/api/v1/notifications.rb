module V1
  class Notifications < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :notifications do
      desc "通知",
        is_array: true,
        http_codes: [
          [200, '成功', V1::Entities::Notification],
          [401, '未授权', V1::Entities::Error]
        ]
      paginate per_page: 10, max_per_page: 200
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :page, type: Integer, default: 1, desc: "页码"
        optional :per_page, type: Integer, default: 10, desc: '每页数量'
      end
      get do
        result = paginate current_user.notifications.order('id DESC')
        present result, with: V1::Entities::Notification
      end
    end
  end
end
