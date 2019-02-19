class TweetsHashtagsRelationship < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :tweet
end
