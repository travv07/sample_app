module ApplicationHelper
  def full_title page_title
    base_title = I18n.t ".title_page"
    page_title.blank? ? base_title : page_title + t("._title") + base_title
  end
end
