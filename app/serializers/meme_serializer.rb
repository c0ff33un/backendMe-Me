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
	attributes :id, :img, :creator, :reaction_counts
	has_many :comments, serializer: CommentSerializer
	def creator
		{
			id: self.object.user.id,
			handle: self.object.user.handle
		}
	end

	def img
		self.object.picture.image
	end
	
	def reaction_counts
		{
			up: self.object.swipe_up,
			down: self.object.swipe_down,
			left: self.object.swipe_left,
			right: self.object.swipe_right
		}
	end
end
