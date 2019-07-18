# Important commands to use: db:drop, db:create, db:seed
require 'open-uri'

#Progress bar

amounts = {
	users: 1,
	memes: 20,
	templates: 0,
	posts: 0,
	reactions: 20,
	comments: 0
}
total = amounts.values.inject(0,:+)
progressbar = ProgressBar.create(total: total, :format => '%a |%b>>%i| %p%% %t')


#Fill User
amounts[:users].times do |n|
	user = User.new
	user.handle = Faker::Internet.unique.username(5..20)
	user.email = Faker::Internet.unique.email
	user.password = Faker::Internet.password
	user.birthday = Faker::Date.birthday(min_age = 15, max_age = 125)
	user.avatar.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
	user.save
	progressbar.increment
end


#Fill Meme 
amounts[:memes].times do |n|
	meme = Meme.new
	meme.user_id = rand(User.count) + 1
	meme.image.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
	meme.save
	progressbar.increment
end

#Fill Template
amounts[:templates].times do |n|
	template = Template.new
	template.description = Faker::Lorem.paragraph,
	template.image.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
	template.save
	progressbar.increment
end

#Fill Post
amounts[:posts].times do
	memes = []
	rand(1..10).times do
		memes<<{meme_id: rand(Meme.count)+1, body: Faker::Lorem.paragraph}
	end
	Post.create(
		user_id: rand(User.count) + 1,
		body: Faker::Lorem.sentence,
		post_memes_attributes: memes
	)
	progressbar.increment
end

#Fill Reaction
amounts[:reactions].times do
	Reaction.create(
		user_id: rand(User.count) + 1,
		meme_id: rand(Meme.count) + 1,
		reaction_type: rand(4)
	)
	progressbar.increment
end


#Fill Comments
amounts[:comments].times do
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
	progressbar.increment
end