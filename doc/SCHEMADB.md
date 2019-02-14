# Database Design for NanoTwitter

# ALL TABLES:

## Users
* string **name**
* text **profile**
* date **birthday**

## Tweets
* integer **user_id**         `foreign_key`
* integer **comment_to**      `index` 
* integer **retweet_from**    `index` 
* text **contents**
* timestamp **post_time**

## Tweets_HashTags
* integer: **tweet_id**
* integer: **hashtag_id**

## Hashtags
* string: **name**
* integer: **tweets_count**

## Follows
* integer: **follower_id**    `foreign_key`
* integer: **followee_id**    `foreign_key`

## Notificationss
* text: **contents**
* string: **notification_type**
* integer: **tweet_id**       `foreign_key`
* integer: **to_user**        `foreign_key`
* integer: **from_user**      `foreign_key`

## Likes
* integer: **user_id**
* integer: **tweet_id**