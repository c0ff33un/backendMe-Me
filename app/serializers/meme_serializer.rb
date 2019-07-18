# == Schema Information
#
# Table name: memes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  swipe_up    :integer          default(0)
#  swipe_down  :integer          default(0)
#  swipe_left  :integer          default(0)
#  swipe_right :integer          default(0)
#

class MemeSerializer < ActiveModel::Serializer
	include Rails.application.routes.url_helpers
	attributes :id, :creator, :reaction_counts
	attribute :img, if: -> {rule == 'FULL_SIZE'}
  attribute :thumbnail, if: -> {rule == 'THUMBNAIL'}
	attribute :reaction_signed_user, if: -> {current_user}
	def rule
    rule = (instance_options[:rule])? instance_options[:rule].upcase.to_s : 'THUMBNAIL'
  end
	
	def current_user
		current_user = instance_options[:current_user]
	end

	def creator
		{
			id: object.user.id,
			handle: object.user.handle,
			avatar: (object.user.avatar.attached?)? rails_blob_url(object.user.avatar):nil
		}
	end

	def reaction_signed_user
		reaction = Reaction.find_by(user_id: current_user.id, meme_id: object.id)
		reaction[:reaction_type] if reaction
	end
	def img
    rails_blob_url(object.image) if object.image.attached?
	end
	
	def thumbnail
		rails_representation_url(
      self.object.image.variant(
        combine_options: {
          resize: "240^>",
          crop: "240x240+0+0"
        }
      ).processed
    )
	end
	def reaction_counts
		{
			up: object.swipe_up,
			down: object.swipe_down,
			left: object.swipe_left,
			right: object.swipe_right
		}
	end

end
