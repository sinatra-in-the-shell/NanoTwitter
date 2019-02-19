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

ActiveRecord::Schema.define(version: 2019_02_19_185057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.index ["from_user_id"], name: "index_follows_on_from_user_id"
    t.index ["to_user_id"], name: "index_follows_on_to_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "comment_to_id"
    t.bigint "retweet_from_id"
    t.text "text"
    t.string "tweet_type"
    t.index ["comment_to_id"], name: "index_tweets_on_comment_to_id"
    t.index ["retweet_from_id"], name: "index_tweets_on_retweet_from_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "display_name"
    t.string "region"
    t.date "date_of_birth"
    t.text "bio"
    t.string "password"
  end

end
