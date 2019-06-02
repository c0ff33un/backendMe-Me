class TemplateSerializer < ActiveModel::Serializer
  attributes :id, :description, :img, :created_at
  def img
    self.object.picture.image
  end
end
