module EmailHelper
  def email_image_tag(image, **options)
    attachments[image] = File.read(Rails.root.join("app/assets/#{image}"))
    image_tag attachments[image].url, **options
  end

  def email_stylesheet_tag(stylesheet, **options)
    stylesheet_link_tag Rails.root.join("app/assets/#{stylesheet}")
  end
end