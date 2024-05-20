module ApplicationHelper
  def set_page_title(title)
    content_for(:title) { title }
  end

  def get_page_title(separator = " - ")
    [content_for(:title), 'Chamber'].compact.join(separator)
  end
end
