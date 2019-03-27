### Redis fanout problems

0. consistency issue with database

1. where to instantiate `redis client`, 
	in `app.rb`? `fanout_helper.rb`?

2. where should I put `fanout_helper` method inside `tweet_api`?
	
3. should the cache list be cleared after it gets too big?

4. store html? json of tweet? tweet_id?

5. test interface integration with `tweet_api`, now they are separated, only `tweet_api` will fanout to redis


### Redis friendship problems

0. consistency issue
