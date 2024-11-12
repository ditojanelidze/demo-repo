# frozen_string_literal: true

module PasswordRecoveries
  class Create
    include ApplicationInteractor

    attr_reader :user

    def call
      @user = User.find_by(phone_number: full_phone_number(context))

      set_password_recovery_attributes
      context.user = user
      if user.save
        send_sms_confirmation_code
      else
        context.fail!
      end
    rescue StandardError => e
      user.errors.add(:base, e.message)
      context.fail!(error: e)
    ensure
      context.user = user
    end

    private

    def set_password_recovery_attributes
      user.password_recovery_code = SecureRandom.random_number(10_000).to_s.rjust(4, '0')
      user.password_recovery_token = SecureRandom.hex
      user.password_recovery_code_sent_at = DateTime.now
    end

    def send_sms_confirmation_code
      sms_text = I18n.t('sms.password_recovery_confirmation_code', code: user.password_recovery_code)
      SmsService.call(user.phone_number, sms_text)
    end
  end
end
