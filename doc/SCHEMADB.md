# Database Design for NanoTwitter

# ALL TABLES:

## Users
* name:
* profile:
* birthday:

## Tweets
* user_id:
* comment_to:
* retweet_from:
* text:
* post_time:

## Tweets_HashTags
* tweet_id:
* hashtag_id:

## Hashtags
* name:
* tweets_count:

## Followers_Followees
* follower_user_id:
* followee_user_id:

## Notificationss
* text:
* type:
* tweet_id:

## Users_Likes
* user_id:
* tweet_id: