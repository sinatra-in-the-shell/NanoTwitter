class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.references :user
      t.references :comment_to
      t.references :retweet_from

      t.text :text
      t.string :tweet_type
      t.timestamps
    end
  end
end
