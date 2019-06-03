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
  attributes :id, :description, :img, :created_at
  def img
    self.object.picture.image
  end
end
