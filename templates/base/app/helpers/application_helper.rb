# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  def model_title(model, title, default: nil)
    return title if title.present?

    default || "#{model.model_name.human} ##{model.id}"
  end

  def model_value(model, field, default: '---')
    model.try(field) || default
  end

  def delete_button_with_dialog(message, button_text, resource, class:)
    render partial: 'application/delete_button_with_dialog', locals: { message:, button_text:, resource:, class: }
  end
end
