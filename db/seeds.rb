# Important commands to use: db:drop, db:create, db:seed

#Fill User
15.times do
    User.create(
        handle: Faker::Internet.username,
        age: Faker::Number.between(15,60),
        pass: Faker::Internet.password,
        password_salt: Faker::Internet.password
    )
end

#Fill Meme
15.times do
    Meme.create(
        user_id: rand(User.count) + 1
    )
end

#Fill Template
15.times do
    Template.create(
        description: Faker::Lorem.paragraph
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

#Fill Pictures
15.times do

    meme = Meme.order('RANDOM()').first
    
    if( meme.picture == nil )
        meme.create_picture(
            image: Faker::Avatar.image
        )
    end

    user = User.order('RANDOM()').first
    
    if( user.picture == nil )
        user.create_picture(
            image: Faker::Avatar.image
        )
    end

    template = Template.order('RANDOM()').first
    
    if( template.picture == nil )
        template.create_picture(
            image: Faker::Avatar.image
        )
    end

end