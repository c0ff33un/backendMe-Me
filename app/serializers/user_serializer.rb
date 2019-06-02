class UserSerializer < ActiveModel::Serializer
  attributes :id, :handle, :birthday, :created_at, :img
  def img
    self.object.picture.image
  end
end
