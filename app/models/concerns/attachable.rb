# frozen_string_literal: true

module Attachable
  extend ActiveSupport::Concern

  def attach(photo, attribute)
    send(attribute).attach(io: photo, filename: photo.original_filename,
                           key: "#{self.class.name}/#{id}/#{photo.original_filename}")
  end
end
