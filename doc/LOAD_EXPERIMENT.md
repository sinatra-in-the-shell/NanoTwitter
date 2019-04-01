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
* Compare response time between `Webrick`(160ms) and `Thin`(22ms)

## Random User Timeline Test (Redis vs without Redis)

* Number of Clients: 30
* Duration: 1 min
* Data: Import 300 test users from test interface
* Redis: Request method and URL: `GET /api/timeline?test_user=?&limit=100`
* Without Redis: Request method and URL: `GET /api/timeline/uncached?test_user=?&limit=100`

* Note: 
  1. larger amount of clients will cause Redis `max number clients` error, it seems we need to change `RedisClient.rb` to restrict or use a queue for redis job to handle
  2. at least for 1min test, redis cache is not really imporving performance comparing with raw database query to get timeline, but could be curtial when we do micro service architecture, or may increase response time for this api

