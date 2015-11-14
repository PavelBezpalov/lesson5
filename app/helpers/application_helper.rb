module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML
    opts = {fenced_code_blocks: true,
            autolink: true,
            tables: true,
            footnotes: true}
    markdown = Redcarpet::Markdown.new(renderer, opts)
    markdown.render(text).html_safe
  end

  def field_class(obj, key)
    return 'group' if obj.nil?
    'errors' if obj.errors[key].present? ||
        (key == :password && obj.errors[:password_confirmation].present?)
  end

  def error_message(obj, key)
    return if obj.nil?
    obj.errors[key].first
  end

  def gravatar(user)
    gravatar_image_tag(user.email,
                        alt: user.name,
                        class: 'some-class',
                        gravatar: { size: 28 })
  end
end
