# frozen_string_literal: true

class PasswordStrengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value

    return if value =~ /[A-Za-z]/ && value =~ /[0-9]/ && value.length >= 8

    record.errors.add(attribute, :invalid, message: I18n.t('custom_errors.passwords_invalid'))
  end
end
