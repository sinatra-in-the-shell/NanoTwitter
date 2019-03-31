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

newFollow()
	delete cache
	update db

readFollowers()
	read from cache
	if not exists
		read from db
		update cache
	return

this structure?
will delete cache be wasteful? then we just update cache everytime there is a new follow

split to a user&follow service?
	api that uses `User`:
		session_helper -> current_user method
		seed_helper
		random_tweet_helper

		user_api
		tweet_api -> current_user
		timeline_api -> current_user
		session_api
		follow_api -> current_user, json the whole user

replicate db to different services?