# NanoTwitter Routes 


## GET:
* /
* /login
* /register
* /users/`NAME` 
  * /
  * /profile
  * /followers
  * /followees
  * /profile 
  * /`TWEET_ID`
  * /notifications
  * /likes
* /search?`ARGS`
* /hashtag/`HASHTAG_NAME`

## POST:
* /login
* /register
* /tweet
* /users/`NAME`/
  * /follow
  * /unfollow
  * /`TWEET_ID`/like

## PUT:
* /users/`NAME`/profile

## DELETE: