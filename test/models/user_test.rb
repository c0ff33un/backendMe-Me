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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
  end

  test "valid user" do
    @user.avatar.attach({io: open(Faker::Avatar.image), filename: "faker_image.jpg"})
    assert @user.valid?
  end

  test "valid user no avatar" do
    assert @user.valid?
  end

  test "invaild user no handle" do
    @user.handle = nil
    assert_not @user.valid?
  end

  test "invaild user no email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "invaild user no birthday" do
    @user.birthday = nil
    assert_not @user.valid?
  end
end
