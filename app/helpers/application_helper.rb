module ApplicationHelper
  def my_category_helper
    @categories=Category.all
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"]="display none"
    end
    content_tag("div", attributes, &block)
  end

  #returns an <li class="active">s if current path is path, else returns <li>
  def active_li(path)
    "active" if current_page?path
  end
end
