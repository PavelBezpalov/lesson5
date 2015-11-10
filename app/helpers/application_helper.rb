module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(text).html_safe
  end
end
