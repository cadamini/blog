require 'redcarpet'

module ApplicationHelper
  def markdown(text)
    options = {
      escape_html: false,
      filter_html: true,
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

    markdown.render(text).html_safe
  end
end
