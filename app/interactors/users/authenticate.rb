# frozen_string_literal: true

module Users
  class Authenticate
    include ApplicationInteractor

    def call
      user = User.find_by(phone_number: full_phone_number(context))

      if user&.authenticate(context.params[:password])
        context.user = user
      else
        context.fail!
      end
    end
  end
end
