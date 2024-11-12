# frozen_string_literal: true

module ApplicationInteractor
  extend ActiveSupport::Concern

  included do
    include Interactor
  end

  def full_phone_number(context)
    codes = { 'ge' => '+995' }
    iso_code = context.params[:phone_number_iso]
    phone_number = context.params[:phone_number].gsub(' ', '')
    "#{codes[iso_code]}#{phone_number}"
  end
end
