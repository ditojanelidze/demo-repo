# frozen_string_literal: true

module Users
  class Create
    include ApplicationInteractor

    attr_reader :user

    before do
      context.params[:phone_number] = full_phone_number(context)
    end

    def call
      @user = User.new(context.params)
      set_phone_confirmation_attributes
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

    def set_phone_confirmation_attributes
      user.phone_number_confirmation_code = SecureRandom.random_number(10_000).to_s.rjust(4, '0')
      user.phone_number_confirmation_token = SecureRandom.hex
      user.phone_number_confirmation_code_sent_at = DateTime.now
    end

    def send_sms_confirmation_code
      sms_text = I18n.t('sms.sign_up_confirmation_code', code: user.phone_number_confirmation_code)
      SmsService.call(user.phone_number, sms_text)
    end
  end
end
