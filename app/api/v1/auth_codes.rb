module V1
  class AuthCodes < Grape::API
    resource :auth_codes do
      desc '发送短信验证码', {
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

        auth_code = AuthCode.where(phone: phone).first
        if auth_code && !auth_code.is_can_resend
          return {
            code: 2,
            msg: '你发送过于频发，请稍后重试'
          }
        end

        code = AuthCode.generate phone
        SmsJob.perform_later phone, 943151

        {
          code: 0,
          msg: '发送成功'
        }
      end

      desc '发送语音验证码', {
        hidden: true,
        notes: <<-NOTE
          * 每个手机号每分钟只能发送一次验证码，重复发送返回失败
          * 验证码有效期为10分钟
          * 如果验证码没有被验证，有效期内重发验证码相同
        NOTE
      }
      params do
        requires :phone, type: String, desc: "手机号"
      end
      post :voice do
        phone = params[:phone]

        auth_code = AuthCode.where(phone: phone).first
        if auth_code && !auth_code.is_can_resend
          return {
            code: 2,
            msg: '你发送过于频发，请稍后重试'
          }
        end

        code = AuthCode.generate phone
        # VoiceCodeWorker.perform_later phone, code

        {
          code: 0,
          msg: '发送成功'
        }
      end
    end
  end
end