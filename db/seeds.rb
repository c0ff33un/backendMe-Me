# Important commands to use: db:drop, db:create, db:seed
require 'open-uri'
#Fill User
5.times do |n|
	user = User.new
	user.handle = Faker::Internet.unique.username(5..20)
	user.email = Faker::Internet.unique.email
	user.password = Faker::Internet.password
	user.birthday = Faker::Date.birthday(min_age = 15, max_age = 125)
	user.avatar.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
	user.save
end


#Fill Meme 
5.times do |n|
	meme = Meme.new
	meme.user_id = rand(User.count) + 1
	meme.image.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
	meme.save
end

#Fill Template
15.times do |n|
	template = Template.new
	template.description = Faker::Lorem.paragraph,
	template.image.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
	template.save
end

#Fill Post
15.times do
	Post.create(
		user_id: rand(User.count) + 1,
		body: Faker::Lorem.sentence,
		post_memes_attributes: [
			{
				meme_id: rand(Meme.count)+1,
				body: Faker::Lorem.paragraph
			}
		]
	)
end

#Fill Reaction
15.times do
	Reaction.create(
		user_id: rand(User.count) + 1,
		meme_id: rand(Meme.count) + 1,
		reaction_type: rand(4) 
	)
end


#Fill Comments
15.times do
	post = Post.order('RANDOM()').first
	post.comments.create(
		user_id: rand(User.count) + 1,
		body: Faker::Lorem.paragraph
	)

	meme = Meme.order('RANDOM()').first
	meme.comments.create(
		user_id: rand(User.count) + 1,
		body: Faker::Lorem.paragraph
	)
end