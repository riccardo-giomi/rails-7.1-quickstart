# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def model_title(model, attribute_name, default: nil)
    title = model.try(attribute_name)
    return title if title.present?

    default || "#{model.model_name.human} ##{model.id}"
  end

  def model_value(model, attribute_name, default: '---')
    value = model.try(attribute_name)
    return default if value.blank?

    value = I18n.l value if value.respond_to?(:strftime)
    value
  end

  def default_image_tag(image)
    filename = image.filename.sanitized
    image_tag image, alt: filename, title: filename
  end

  def delete_button_with_dialog(message, button_text, resource, class:)
    render partial: 'application/delete_button_with_dialog', locals: { message:, button_text:, resource:, class: }
  end
end
