class TweetsHashtagsRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets_hashtags_relationships do |t|
      t.references :hashtag
      t.references :tweet
      t.timestamp
    end
  end
end
