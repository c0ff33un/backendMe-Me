class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :birthday, :created_at
  attribute :img, if: :img_not_nil?

  def img_not_nil?
    true if object.picture
  end

  def img
    self.object.picture.image
  end
end
