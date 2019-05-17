# Important rake commands to use: rake db:drop, rake db:create, rake db:seed

15.times do
    User.create(
        handle: Faker::Internet.username,
        age: Faker::Number.between(15,60),
        pass: Faker::Internet.password,
        password_salt: Faker::Internet.password
    )
end

15.times do
    Meme.create(
        user_id: rand(User.count) + 1,
        image: Faker::Avatar.image
    )
end

15.times do
    Post.create(
        user_id: rand(User.count) + 1,
        body: Faker::Lorem.sentence
    )
end

15.times do
    Reaction.create(
        user_id: rand(User.count) + 1,
        meme_id: rand(Meme.count) + 1,
        reaction_type: rand(5) 
    )
end


15.times do
    PostMeme.create(
        post_id: rand(Post.count) + 1,
        meme_id: rand(Meme.count) + 1,
        body: Faker::Lorem.sentence   
    )
end


15.times do

    post = Post.order('RANDOM()').first
    post.comments.create(
        user_id: rand(User.count) + 1,
        body: Faker::Lorem.paragraph
    )

    postMeme = PostMeme.order('RANDOM()').first
    postMeme.comments.create(
        user_id: rand(User.count) + 1,
        body: Faker::Lorem.paragraph
    )

end
