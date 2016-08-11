module V1
  class Users < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :users do
      desc "在线用户数", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [200, '成功', V1::Entities::Data],
          [401, '未授权', V1::Entities::Error],
        ]
      }
      get :online_count do
        count = User.online.count

        result = {count: count}

        present result
      end


      desc "用户详情", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [200, '成功', V1::Entities::User],
          [401, '未授权', V1::Entities::Error],
          [404, '未找到', V1::Entities::Error],
        ]
      }
      params do
        requires :id, type: Integer, desc: "用户编号"
      end
      route_param :id do
        get do
          user = User::find(params[:id])
          if user.id!=current_user.id
            error!('Not Found', 404)
          end

          present user, with: V1::Entities::User
        end
      end

      desc '更新用户信息', {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [201, '成功', V1::Entities::User],
          [401, '未授权', V1::Entities::Error],
          [404, '未找到', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      }
      params do
        requires :avatar, type: File, desc: '头像'
        requires :name, type: String, desc: '姓名'
        requires :address, type: String, desc: '地址'
        requires :gender, type: String, desc: '性别, 男, 女'
        requires :birth, type: String, desc: '出生日期'
        requires :education, type: Integer, desc: '学历'
        requires :job, type: String, desc: '职业'
        requires :church, type: String, desc: '教会'
        requires :church_service, type: String, desc: '教会服侍'
        requires :rebirth, type: String, desc: '信主时间'
        requires :area, type: String, desc: '代祷区域'
        requires :period, type: Integer, desc: '代祷时段'
      end
      route_param :id do
        put do
          user = User::find(params[:id])
          if user.id!=current_user.id
            error!('Not Found', 404)
          end

          safe_params = clean_params(params).permit(:name, :address, :gender, :birth, :education,
              :job, :church, :church_service, :rebirth, :area, :period, :avatar)

          user.avatar = params[:avatar]

          if user.update(safe_params)
            present user, with: V1::Entities::User
          else
            error!(user.errors.full_messages.first, 422)
          end
        end
      end

      desc '更新用户在线状态(此接口，客户端每分钟调用一次)', {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [201, '成功', V1::Entities::Result],
          [401, '未授权', V1::Entities::Error],
          [404, '未找到', V1::Entities::Error],
        ]
      }
      route_param :id do
        put :online do
          user = User::find(params[:id])
          if user.id!=current_user.id
            error!('Not Found', 404)
          end

          User.where(id: user.id).update_all(online_at: Time.now)

          result = {result: true}
          status 201
          present result
        end
      end
    end
  end
end
