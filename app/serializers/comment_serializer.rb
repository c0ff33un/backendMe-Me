# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  commentable_type :string
#  commentable_id   :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user, :body, :created_at, :edited 
  def edited
    self.object.created_at != self.object.updated_at
  end
  def user
    {
      id: self.object.user.id,
      handle: self.object.user.handle
    }
  end
end

# create_table "comments", force: :cascade do |t|
#   t.integer "user_id"
#   t.string "commentable_type"
#   t.integer "commentable_id"
#   t.text "body"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
#   t.index ["user_id"], name: "index_comments_on_user_id"
# end
