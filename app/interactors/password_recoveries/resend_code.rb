# frozen_string_literal: true

module PasswordRecoveries
  class ResendCode
    include Interactor

    attr_reader :user

    def call
      @user = User.find_by(password_recovery_token: context[:password_recovery_token])
      reset_password_recovery_confirmation_code
      context.user = user
      if user.save!
        send_sms_confirmation_code
      else
        user.errors.add(:password_recovery_code, I18n.t('labels.user_management.could_not_resend_confirmation_code'))
        context.fail!
      end
    end

    def reset_password_recovery_confirmation_code
      user.password_recovery_code = SecureRandom.random_number(10_000).to_s.rjust(4, '0')
      user.password_recovery_code_sent_at = DateTime.now
    end

    def send_sms_confirmation_code
      sms_text = I18n.t('sms.password_recovery_confirmation_code', code: user.phone_number_confirmation_code)
      SmsService.call(user.phone_number, sms_text)
    end
  end
end
