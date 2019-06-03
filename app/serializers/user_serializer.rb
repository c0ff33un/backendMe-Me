# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  handle                 :string
#  birthday               :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

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
