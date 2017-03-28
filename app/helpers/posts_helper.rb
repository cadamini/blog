module PostsHelper
  def resolve_category_by_name(id)
    if id.nil?
      return "none"
    else
      Category.find(id).name
    end
  end

  def to_html(content)
    content.html_safe
  end
end
