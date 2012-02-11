module ApplicationHelper

  def logo
   logo = image_tag("logo.png", alt: "Mini Twitter", class: "round")
  end

  def full_title(page_title)
    base_title = "Mini Twitter demo app"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
