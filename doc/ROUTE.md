# NanoTwitter Routes 


GET:
=====
* **/:** homepage.
* **/login:** login page.
* **/register:** registration page.
* **/users/`NAME`:** all urls below are pages corresponding to user @`NAME`.
  * **/profile:** profile page.
  * **/followers:** all followers of that user.
  * **/followees:** all following/followees of that user.
  * **/`TWEET_ID`:** a certain tweet posted by that user. 
  * **/notifications:** all notifications received.
  * **/likes:** all tweets liked by the user.
* **/search?`ARGS`:** search result page.
* **/hashtag/`HASHTAG_NAME`:** page for hashtag \#`HASHTAG_NAME`

POST:
=====
* **/login:** login request.
* **/register:** register request.
* **/tweet** post a new tweet.
* **/users/`NAME`**
  * **/follow:** follow a certain user. 
  * **/unfollow:** unfollow a certain user.
  * **/`TWEET_ID`/like:** like a tweet of a user.

PUT:
=====
* **/users/`NAME`/profile:** update one's profile. 

DELETE:
=====