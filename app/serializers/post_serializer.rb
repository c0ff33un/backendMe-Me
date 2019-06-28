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
  include Rails.application.routes.url_helpers
  attributes :id, :creator, :body
  attribute :memes, if: -> {rule == 'FULL_SIZE'}
  attribute :thumbnail, if: -> {rule == 'THUMBNAIL'}

  def rule
    rule = (instance_options[:rule])? instance_options[:rule].upcase.to_s : 'THUMBNAIL'
  end
  def creator
    {
      id: self.object.user.id,
      handle: self.object.user.handle
    }
  end

  def memes
    # shitty query to avoid active storage N + 1
    memes = Meme.with_attached_image.joins(:post_memes).where('post_memes.post_id' => object.id).select('memes.*','post_memes.id as post_meme_id','post_memes.body')
    memes.map do |meme|
      {
        post_meme_id: meme.post_meme_id,
        meme_id: meme.id,
        body: meme.body,
        img: (meme.image.attached?)? rails_blob_url(meme.image) : nil
      }
    end
  end

  def thumbnail
    rails_representation_url(
      self.object.memes.first.image.variant(
        combine_options: {
          resize: "240^>",
          crop: "240x240+0+0"
        }
      ).processed
    )
  end
end