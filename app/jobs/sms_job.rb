class SmsJob < ApplicationJob
  queue_as :default

  def perform(phone, code)
    # Do something later
  end
end
