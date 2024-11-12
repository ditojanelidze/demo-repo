# frozen_string_literal: true

class SmsService
  class << self
    def call(phone_number, sms_text)
      Rails.logger.info "SMS SENT TO #{phone_number} - #{sms_text}"
      # send sms by pushing messages to background job
    end
  end
end
