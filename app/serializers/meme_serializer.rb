class MemeSerializer < ActiveModel::Serializer
	attributes :id, :img, :creator, :reaction_counts

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