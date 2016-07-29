module V1
  class Users < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :users do
      # desc "用户详情"
      # params do
      #   requires :id, type: Integer, desc: "用户编号"
      # end
      # route_param :id do
      #   get do
      #     present User.find(params[:id]), with: V1::Entities::User
      #   end
      # end

      desc '更新用户信息', {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [201, '成功', V1::Entities::User],,
          [401, '未授权', V1::Entities::Error]
          [422, '错误', V1::Entities::Error]
        ]
      }
      params do
        requires :name, type: String, desc: '姓名'
        requires :address, type: String, desc: '地址'
        requires :gender, type: String, desc: '性别, 男, 女'
        requires :birth, type: String, desc: '出生日期'
        requires :education, type: Integer, desc: '学历'
        requires :job, type: String, desc: '职业'
        requires :church, type: String, desc: '教会'
        requires :church_service, type: String, desc: '教会服侍'
        requires :rebirtch, type: String, desc: '信主时间'
        requires :area, type: String, desc: '代祷区域'
        requires :period, type: Integer, desc: '代祷时段'
      end
      route_param :id do
        put do
          authenticate!

          user = User::find(params[:id])
          if user.id!=current_user.id
            error!('Not Found', 404)
          end

          safe_params = clean_params(params).permit(:name, :address, :gender, :birth, :education,
              :job, :church, :church_service, :rebirtch, :area, :period)

          if user.update(safe_params)
            present user, with: V1::Entities::User
          else
            error!({ error: user.errors.full_messages.first }, 422)
          end
        end
      end
    end
  end
end
