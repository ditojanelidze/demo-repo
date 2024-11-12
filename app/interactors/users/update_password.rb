# frozen_string_literal: true

module Users
  class UpdatePassword
    include Interactor

    def call
      user = context.user
      if user.authenticate(context.params[:password])
        context.fail! unless user.update(password: context.params[:new_password])
      else
        user.errors.add(:password, :invalid)
        context.fail!
      end
    end
  end
end
