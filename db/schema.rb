# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_17_173833) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "memes", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_memes_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.binary "image"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "post_memes", force: :cascade do |t|
    t.integer "post_id"
    t.integer "meme_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_post_memes_on_meme_id"
    t.index ["post_id"], name: "index_post_memes_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "meme_id"
    t.integer "reaction_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_reactions_on_meme_id"
    t.index ["user_id"], name: "index_reactions_on_user_id"
  end

  create_table "templates", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "handle"
    t.integer "age"
    t.string "pass"
    t.string "password_salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
