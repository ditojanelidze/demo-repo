# frozen_string_literal: true

class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if Phonelib.valid_for_country? value, record.phone_number_iso

    record.errors.add(attribute, :invalid)
  end
end
