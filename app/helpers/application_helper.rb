require 'redcarpet'

module ApplicationHelper
  def markdown(text)
    options = {
      escape_html: true,
      hard_wrap:       true,
      escape_html: true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
    }

    extensions = {
      autolink:           true,
      superscript:        true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text.gsub("\r\n\r\n", "\r\n")).html_safe
  end
end
