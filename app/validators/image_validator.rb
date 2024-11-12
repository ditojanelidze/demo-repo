# frozen_string_literal: true

# app/validators/image_validator.rb
class ImageValidator < ActiveModel::Validator
  def validate(record)
    images = record.images

    return unless images.attached?

    images.each do |image|
      validate_format(record, image)
      validate_size(record, image)
    end
  end

  private

  # Validates the image format
  def validate_format(record, image)
    allowed_types = Rails.application.config.allowed_image_types
    return if allowed_types.include?(image.content_type)

    record.errors.add(:images, "must be a #{Rails.application.config.allowed_image_types.join(', ')}")
  end

  # Validates the image size
  def validate_size(record, image)
    max_size = Rails.application.config.max_image_size.megabytes
    return unless image.byte_size > max_size

    record.errors.add(:images, "must be smaller than #{max_size}MB")
  end
end
