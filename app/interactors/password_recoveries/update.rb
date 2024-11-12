# frozen_string_literal: true

module PasswordRecoveries
  class Update
    include ApplicationInteractor

    attr_reader :user

    def call
      @user = User.find_by(password_recovery_token: context[:password_recovery_token])

      if user.persisted? && valid_code_given? && code_not_expired?
        clear_password_recovery_attributes
        user.password = context.user[:password]
        user.save!
      elsif user.persisted?
        user.errors.add(:password_recovery_code, :invalid)
        context.fail!
      else
        context.fail!
      end
      context.user[:password_recovery_code]
    rescue StandardError => e
      context.fail!(error: e)
    ensure
      context.user = user
    end

    private

    def clear_password_recovery_attributes
      user.password_recovery_code = nil
      user.password_recovery_token = nil
      user.password_recovery_code_sent_at = nil
    end

    def set_password
      user.password = context.user[:password]
    end

    def send_sms_confirmation_code
      sms_text = I18n.t('sms.password_recovery_confirmation_code', code: user.password_recovery_code)
      SmsService.call(user.phone_number, sms_text)
    end

    def valid_code_given?
      user.password_recovery_code == context.user[:password_recovery_code]
    end

    def code_not_expired?
      DateTime.now < user.password_recovery_code_sent_at + 10.minutes
    end
  end
end
