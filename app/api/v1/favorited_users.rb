module V1
  class FavoritedUsers < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :favorited_users do
      desc "关注的用户",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        is_array: true,
        http_codes: [
          [200, '成功', V1::Entities::User],
          [401, '未授权', V1::Entities::Error]
        ]
      paginate per_page: 10, max_per_page: 200
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :page, type: Integer, default: 1, desc: "页码"
        optional :per_page, type: Integer, default: 10, desc: '每页数量'
      end
      get do
        result = paginate current_user.favorite_users

        present result, with: V1::Entities::User
      end
    end
  end
end
