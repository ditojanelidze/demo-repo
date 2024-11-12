# frozen_string_literal: true

module Users
  class VerifyPhoneNumber
    include Interactor

    attr_reader :user

    def call
      @user = User.find_by(phone_number_confirmation_token: context[:phone_number_confirmation_token]) || User.new

      if user.persisted?
        handle_code_verification
      else
        context.fail!
      end
    rescue StandardError => e
      user.errors.add(:base, e.message)
      context.fail!(error: e)
    ensure
      context.user = user
    end

    def clear_phone_number_verification_data
      user.phone_number_confirmation_token = nil
      user.phone_number_confirmation_code = nil
      user.phone_number_confirmation_code_sent_at = nil
    end

    def handle_code_verification
      if code_expired?
        fail_with_error(:phone_number_confirmation_code, :expired)
      elsif invalid_code_given?
        fail_with_error(:phone_number_confirmation_code, :invalid)
      else
        activate_user
      end
    end

    def activate_user
      clear_phone_number_verification_data
      user.workflow_state = :active
      user.save!
    end

    def fail_with_error(attribute, error_type)
      user.errors.add(attribute, error_type)
      context.fail!
    end

    def invalid_code_given?
      user.phone_number_confirmation_code != context[:phone_number_confirmation_code]
    end

    def code_expired?
      DateTime.now > user.phone_number_confirmation_code_sent_at + 10.minutes
    end
  end
end
