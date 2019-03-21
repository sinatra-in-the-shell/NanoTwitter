# Load Experiment

This is the description file of the load experiment carried on NT.

## Simultaneous Access Test

* Request method and URL: `GET /register`
* Current setting: 250 users connect to the server and request the register page in 1 minute.
  
## Post-A-Tweet Test

* Request method and URL: `POST /api/tweets`
* Current setting: 250 users post a short tweets in 1 minute.
* Note: Tweets and timeline service not implemented yet. This is just a test of basic database operations.

## Get Tweets Test

* Request method and URL: `GET /test/user/10/tweets`
* Current settting: 250 clients read tweets simultaneously in 1 minute.

## Test Interface Test

* Request method and URL: `POST /test/user/:userid/tweets?count=100`
* Current settting: 250 clients post tweets simultaneously in 1 minute.
* Compare response time between Webrick(160ms) to Thin(22ms)
