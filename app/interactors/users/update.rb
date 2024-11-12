# frozen_string_literal: true

module Users
  class Update
    include Interactor

    def call
      user = context.user
      user.update(context.params)
      context.fail! unless user.update(context.params)
    rescue StandardError => e
      user.errors.add(:base, e.message)
      context.fail!(error: e)
    ensure
      context.user = user
    end
  end
end
