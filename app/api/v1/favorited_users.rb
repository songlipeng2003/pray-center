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
         [200, '成功', V1::Entities::User]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present current_user.favorite_users.all, with: V1::Entities::User
      end
    end
  end
end
