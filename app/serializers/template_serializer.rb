# == Schema Information
#
# Table name: templates
#
#  id          :integer          not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TemplateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :description, :created_at, :img
  def img
    rails_blob_url(object.image) if object.image.attached?
  end
end
