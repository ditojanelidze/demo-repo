# frozen_string_literal: true

class AvatarValidator < ActiveModel::Validator
  def validate(record)
    return unless record.avatar&.attached?

    if record.avatar.byte_size > Rails.application.config.max_image_size.megabytes
      record.errors.add(:avatar,
                        'is too big. Max size is 1MB')
    end

    return if Rails.application.config.allowed_image_types.include?(record.avatar.content_type)

    record.errors.add(:avatar, 'must be a JPEG, JPG, PNG or WEBP')
  end
end
