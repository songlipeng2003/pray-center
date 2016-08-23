module V1
  class AuthCodes < Grape::API
    resource :auth_codes do
      desc '发送短信验证码', {
        http_codes: [
          [201, '成功', V1::Entities::Result],
          [422, '错误', V1::Entities::Error]
        ],
        notes: <<-NOTE
          * 每个手机号每分钟只能发送一次验证码，重复发送返回失败
          * 验证码有效期为10分钟
          * 如果验证码没有被验证，有效期内重发验证码相同
        NOTE
      }
      params do
        requires :phone, type: String, desc: "手机号"
      end
      post do
        phone = params[:phone]

        if phone && phone.length!=11
          error!('手机号错误', 422)
        end

        auth_code = AuthCode.where(phone: phone).first
        if auth_code && !auth_code.is_can_resend
          error!('你发送过于频发，请稍后重试', 422)
        else
          code = AuthCode.generate phone
          SmsJob.perform_later phone, code

          {
            result: 0,
          }
        end
      end
    end
  end
end
