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

ActiveRecord::Schema.define(version: 2019_04_20_022308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id", "to_user_id"], name: "index_follows_on_from_user_id_and_to_user_id", unique: true
    t.index ["from_user_id"], name: "index_follows_on_from_user_id"
    t.index ["to_user_id"], name: "index_follows_on_to_user_id"
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_likes_on_tweet_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.bigint "tweet_id"
    t.string "notification_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id"], name: "index_notifications_on_from_user_id"
    t.index ["to_user_id"], name: "index_notifications_on_to_user_id"
    t.index ["tweet_id"], name: "index_notifications_on_tweet_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "comment_to_id"
    t.bigint "retweet_from_id"
    t.text "text"
    t.string "tweet_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "display_name"
    t.index "to_tsvector('english'::regconfig, text)", name: "tweets_to_tsvector_idx", using: :gin
    t.index ["comment_to_id"], name: "index_tweets_on_comment_to_id"
    t.index ["retweet_from_id"], name: "index_tweets_on_retweet_from_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "tweets_hashtags_relationships", force: :cascade do |t|
    t.bigint "hashtag_id"
    t.bigint "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashtag_id"], name: "index_tweets_hashtags_relationships_on_hashtag_id"
    t.index ["tweet_id"], name: "index_tweets_hashtags_relationships_on_tweet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "display_name"
    t.string "region"
    t.date "date_of_birth"
    t.text "bio"
    t.string "password_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email"
  end

end
