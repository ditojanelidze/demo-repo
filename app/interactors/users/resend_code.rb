# frozen_string_literal: true

module Users
  class ResendCode
    include Interactor

    attr_reader :user

    def call
      @user = User.find_by(phone_number_confirmation_token: context[:phone_number_confirmation_token])
      reset_phone_number_confirmation_code
      context.user = user
      if user.save!
        send_sms_confirmation_code
      else
        user.errors.add(:phone_number_confirmation_code,
                        I18n.t('labels.user_management.could_not_resend_confirmation_code'))
        context.fail!
      end
    end

    def reset_phone_number_confirmation_code
      user.phone_number_confirmation_code = SecureRandom.random_number(10_000).to_s.rjust(4, '0')
      user.phone_number_confirmation_code_sent_at = DateTime.now
    end

    def send_sms_confirmation_code
      sms_text = I18n.t('sms.sign_up_confirmation_code', code: user.phone_number_confirmation_code)
      SmsService.call(user.phone_number, sms_text)
    end
  end
end
