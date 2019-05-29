# Important commands to use: db:drop, db:create, db:seed

#Fill User
15.times do
    User.create(
        handle: Faker::Internet.unique.username(5..20),
        email: Faker::Internet.unique.email,
        password: Faker::Internet.password,
        birthday: Faker::Date.birthday(min_age = 15, max_age = 125)
    )
end


#Fill Meme
15.times do
    Meme.create(
        user_id: rand(User.count) + 1,
        picture: Picture.create(
            image: Faker::Avatar.image
        )
    )
end

#Fill Template
15.times do
    Template.create(
        description: Faker::Lorem.paragraph,
        picture: Picture.create(
            image: Faker::Avatar.image
        )
    )
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
        reaction_type: rand(5) 
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

    postMeme = PostMeme.order('RANDOM()').first
    postMeme.comments.create(
        user_id: rand(User.count) + 1,
        body: Faker::Lorem.paragraph
    )

end