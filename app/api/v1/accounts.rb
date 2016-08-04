module V1
  class Accounts < Grape::API
    resource :accounts do
      desc "注册",
        http_codes: [
          [201, '成功', V1::Entities::LoginUser],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        requires :username, type: String, desc: "用户名(第一位必须应为字母，只能小写英文、数字和_的组合，长度6-18位)"
        requires :phone, type: String, desc: "手机号"
        requires :code, type: String, desc: "验证码"
        requires :password, type: String, desc: "密码"
        requires :invitation_code, type: String, desc: "邀请码"
      end
      post 'register' do
        # is_valid = AuthCode.validate_code(params[:phone], params[:code])

        user_id = User.encode_invitation_code(params[:invitation_code])
        parent_user = User.find_by_id(user_id)
        unless parent_user
          error!('邀请码错误', 422)
        end

        # if is_valid
        if true
          user = User.new({
            username: params[:username],
            phone: params[:phone],
            password: params[:password],
            password_confirmation: params[:password],
            parent_id: user_id
          })

          # user.application = current_application

          if user.save
            present user, with: V1::Entities::LoginUser
          else
            error!(user.errors.full_messages.first, 422)
          end
        else
          error!('验证码错误', 422)
        end
      end

      desc "登陆",
        http_codes: [
          [201, '成功', V1::Entities::LoginUser],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        requires :phone, type: String, desc: "手机号"
        requires :password, type: String, desc: "密码"
        optional :device, type: String, desc: "设备唯一编号"
        optional :device_model, type: String, desc: "设备型号，例如：小米Note"
        optional :device_type, type: String, desc: "设备类型，android或者ios"
        optional :jpush, type: String, desc: "极光推送ID(暂时忽略)"
      end
      post 'login' do
        phone = params[:phone]
        user = User.where('phone=?', phone).first

        if user && user.valid_password?(params[:password])
          user.update_tracked_fields!(warden.request)

          present user, with: V1::Entities::LoginUser
        else
          error!('账号或密码错误', 422)
        end

        # user.login_histories.create!({
        #   ip: client_ip,
        #   device: params[:device],
        #   device_model: params[:device_model],
        #   device_type: params[:device_type],
        #   application: current_application
        # })

        # unless params[:device].blank?
        #   device = user.devices.where(code: params[:device]).first_or_create! do |device|
        #     device.device_type = params[:device_type]
        #   end
        #   device.jpush = params[:jpush]
        #   device.save!
        # end
      end
    end
  end
end
