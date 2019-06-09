# Important commands to use: db:drop, db:create, db:seed
require 'open-uri'
#Fill User
5.times do |n|
    user = User.create(
        handle: Faker::Internet.unique.username(5..20),
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password,
        birthday: Faker::Date.birthday(min_age = 15, max_age = 125)
    )
    user.avatar.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
end


#Fill Meme 
5.times do |n|
    meme = Meme.create(
        user_id: rand(User.count) + 1
    )
    meme.image.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
end

#Fill Template
15.times do |n|
    template = Template.create(
        description: Faker::Lorem.paragraph,
    )
    template.image.attach({io: open(Faker::Avatar.image), filename: "#{n}_faker_image.jpg"})
end

#Fill Post
15.times do
    Post.create(
        user_id: rand(User.count) + 1,
        body: Faker::Lorem.sentence
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

#Fill PostMeme
15.times do
    PostMeme.create(
        post_id: rand(Post.count) + 1,
        meme_id: rand(Meme.count) + 1,
        body: Faker::Lorem.sentence   
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