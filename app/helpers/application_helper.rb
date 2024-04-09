module ApplicationHelper
  def present_page?
    return false if request.original_url == "/"
    request.referrer.present?
  end
end
