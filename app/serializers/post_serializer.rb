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
  attributes :id, :creator, :body, :memes, :thumbnail

  def attributes(*args)
    hash = super
    hash.select{|k,v| rule.include?(k)}
  end

  def rule
    rule = (instance_options[:rule])? instance_options[:rule].upcase.to_s : 'THUMBNAIL'
    "PostSerializer::#{rule}".constantize
  end
  def creator
    {
      id: self.object.user.id,
      handle: self.object.user.handle
    }
  end

  def memes
    self.object.post_memes.map do |post_meme|
      {
        post_meme_id: post_meme.id,
        meme_id: post_meme.meme_id,
        body: post_meme.body,
        img: rails_blob_url(post_meme.meme.image)
      }
    end
  end

  def thumbnail
    rails_representation_url(
      self.object.post_memes.first.meme.image.variant(
        combine_options: {
          resize: "400x300>",
          extent: "400x300",
          background: "grey",
          gravity: "North"
        }
      )
    )
  end
  
  THUMBNAIL = [:id, :creator, :body, :thumbnail]
  MEMES = [:id, :creator, :body, :memes]
end