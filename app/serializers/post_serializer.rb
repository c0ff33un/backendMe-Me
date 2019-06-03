# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSerializer < ActiveModel::Serializer
  attributes :id, :creator, :body, :memes
  has_many :comments, serializer: CommentSerializer
  def creator
    {
      id: self.object.user.id,
      handle: self.object.user.handle
    }
  end

  def memes
    self.object.post_memes.map do |post_meme|
      {
        meme_id: post_meme.meme_id,
        img: post_meme.meme.picture.image
      }
    end
  end
end
