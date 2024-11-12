# frozen_string_literal: true

module ApplicationHelper
  def labels_translation(key)
    I18n.t("labels.#{key}")
  end

  def nav_link(path, link_key)
    is_active = current_page?(path)
    link_classes = "flex flex-col items-center #{'text-sky-500' if is_active} text-gray-700 hover:text-sky-500"
    inline_svg_classes = 'h-8 w-8'

    link_to path, class: link_classes do
      concat inline_svg "icons/#{link_key}.svg", class: inline_svg_classes
      concat(content_tag(:span, labels_translation("navigation.#{link_key}"), class: 'hidden lg:block text-sm'))
    end
  end

  def svg_button(path, link_key, options = {})
    styles = options[:class] || 'h-10 w-10 mt-4'
    method = options[:method] || :get
    button_to path, method:, class: styles do
      concat inline_svg "icons/#{link_key}.svg", class: styles
    end
  end

  def form_label(form, field_label, label_translation, css_class: 'block text-sm font-medium leading-6 text-gray-900')
    form.label(field_label, label_translation, class: css_class)
  end

  def render_field_errors(instance, field)
    return unless instance.errors[field].any?

    render 'partials/forms/errors', errors: instance.errors.full_messages_for(field).first
  end

  def form_with_styling(**options, &)
    default_styles = 'space-y-6 mx-4'
    options[:class] = "#{default_styles} #{options[:class]}"
    form_with(**options, &)
  end

  def to_lower_camel_case(str_or_symbol)
    str_or_symbol.to_s.camelize(:lower)
  end

  def form_field_styles
    'block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ' \
      'ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 ' \
      'focus:ring-inset focus:ring-sky-500 sm:text-sm sm:leading-6'
  end
end
