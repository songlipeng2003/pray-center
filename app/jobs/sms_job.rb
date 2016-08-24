class SmsJob < ApplicationJob
  queue_as :default

  def perform(phone, code)
    client = ISMS::Client.new
    response = client.send_sms("你的验证码是：#{code}", phone, 2)
  end
end
