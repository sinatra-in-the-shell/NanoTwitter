# NanoTwitter
[![Maintainability](https://api.codeclimate.com/v1/badges/321abe06b5c265e41552/maintainability)](https://codeclimate.com/github/sinatra-in-the-shell/nt-TweetService/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/321abe06b5c265e41552/test_coverage)](https://codeclimate.com/github/sinatra-in-the-shell/nt-TweetService/test_coverage)
* Course project for Cosi105b - Software Engineering for Scalability.
* Implement an SNS website including most basic funtions of Twitter. Use [Sinatra](http://sinatrarb.com/) + [React](https://reactjs.org/) as primary tech tools.

## Table of Contents
- [NanoTwitter](#nanotwitter)
  - [Table of Contents](#table-of-contents)
  - [Team Member](#team-member)
  - [To Build and Run](#to-build-and-run)
    - [Build Frontend](#build-frontend)
    - [Run](#run)
    - [Test](#test)
  - [Architecture:](#architecture)
  - [Deployment:](#deployment)
  - [Documentations:](#documentations)
  - [Version Changelogs](#version-changelogs)
    - [NT0.1](#nt01)
    - [NT0.2](#nt02)
    - [NT0.3](#nt03)
    - [NT0.4](#nt04)
    - [NT0.5](#nt05)
    - [NT0.6](#nt06)
    - [NT0.7](#nt07)
    - [NT1.0](#nt10)
  - [Relevant URLs](#relevant-urls)

## Team Member
* Fengzhencheng Zeng fzeng@brandeis.edu
* Ziyu Liu ziyuliu@brandeis.edu
* Yirun Zhou yirunzhou@brandeis.edu

## To Build and Run
Ruby, bundler, npm/yarn, postgresql is required to be installed first.

4 Redis server is required to be installed and running to enable caching function.

### Build Frontend
```
bundle install
rake db:create db:migrate
cd client
npm install
npm run build
```
### Run
```
ruby app.rb
```

### Test
```
rake test
```

## Architecture:
* The frontend of NanoTwitter is built with React.js to present a modern UI and allow AJAX requests. 
* The backend of NanoTwitter is built with Sinatra, which is running on a Puma server. The application is deployed on Heroku and uses PgSQL as database and includes multiple redis addon for cache. 
* For the three major requests (timeline, search and post tweet), the application will only hit the database if there is a cache miss. The data retrieved from data base will be cached in corresponding redis server until it’s expired or invalidated by other APIs.


## Deployment:
The project is hooked to [Codeship](https://app.codeship.com/projects/329361) and deployed on [Heroku](https://nano-twitter-sits.herokuapp.com/).

## Documentations:
* [Route](/doc/ROUTE.md)
* [Schema](/doc/SCHEMADB.md)
* [API 1.0](https://app.swaggerhub.com/apis-docs/sinatra-in-the-shell/nano-twitter-api/1.0.0)
* [loadio experiments](/doc/LOAD_EXPERIMENT.md)

## Version Changelogs

### NT0.1
* Created github repo.
* Designed basic UI, routes and schemadb.

### NT0.2
* Created all tables and migrations.
* Created skeleton sinatra app and React app.
* Completed Register/Login pages.
* Implemented authentication mechanism.
* Heroko deployment experiment succeeded.

### NT0.3
* Set up Codeship auto testing and deployment (onto Heroku).
* Designed [NanoTwitter API 1.0](https://app.swaggerhub.com/apis-docs/sinatra-in-the-shell/nano-twitter-api/1.0.0).(**Not implemented yet.**)
* Added unittests on the server side of register/login/authenticate.
* Cookie-based authentication.
* Implemented [test interface](http://cosi105b.s3-website-us-west-2.amazonaws.com/content/topics/nt/01_nt_functionality.md/).


### NT0.4
* Fix some bugs in [test interface] - Fengzhencheng Zeng, Yirun Zhou, Ziyu Liu
* Added loader.io verification and tried some test in loader.io - Yirun Zhou
* Separated api(twitter_api.rb, test_api.rb) from app.rb - Fengzhencheng Zeng

### NT0.5
* Implemented [NanoTwitter API 1.0](https://app.swaggerhub.com/apis-docs/sinatra-in-the-shell/nano-twitter-api/1.0.0). - Fengzhencheng Zeng, Yirun Zhou, Ziyu Liu
* Start using new relic to collect internal performance data. - Yirun Zhou, Ziyu Liu
* Created basic load experiments. Created a [doc file](/doc/LOAD_EXPERIMENT.md) to describe each test. - Ziyu Liu, Yirun Zhou
* Switched to using scope to handle queries with options. See in [user.rb](models/user.rb) and [tweet.rb](models/tweet.rb). - Fengzhencheng Zeng, Ziyu Liu
* Switched web server from `WebBrick` to `thin`. Observed a significant performance improvement. - Fengzhencheng Zeng, Yirun Zhou

### NT0.6
* Updated [NanoTwitter API 1.0](https://app.swaggerhub.com/apis-docs/sinatra-in-the-shell/nano-twitter-api/1.0.0). - Fengzhencheng Zeng, Yirun Zhou, Ziyu Liu
* Implemented user interface of timeline and fix login/logout session issue - Fengzhengcheng Zeng, Ziyu Liu
* Tried React+Redux frontend, implemented a React+Redux login/register model, decided to use only React at last. - Ziyu Liu
* Create home page and other front end components of the app using React. - Fengzhencheng Zeng
* Add index for user and follow relationships. - Yirun Zhou
* Settting up Redis, adding cache retrieving and fanout logics on timeline and post tweet apis. - Yirun Zhou, Ziyu Liu
* Clean code, test and correct minor bugs of apis and tests. - Ziyu Liu

### NT0.7
* Updated fanout and follow api to allow only one global Redis client, passed load testing with multiple clients at a time - Yirun Zhou
* Implemented multiple api call method for frontend api library [nanoAPI](https://github.com/sinatra-in-the-shell/NanoTwitter/blob/master/client/src/nanoAPI.js) - Fengzhencheng Zeng
* Fixed credential system so that advanced login are fully functional - Fengzhencheng Zeng
* Added test status page at frontend - Ziyu Liu

### NT1.0
* Implemented full text search on all the tweets, built index for database, cached results in Redis - Ziyu Liu
* Built front end for search - Fengzengcheng Zeng
* Added test route for posting new random tweet - Ziyu Liu
* Performed load testing on heroku - Ziyu Liu, Fengzengcheng Zeng
* Deployed a branch on Amazon Elastic Beanstalk and performed load testing - Yirun Zhou

## Relevant URLs
* GitHub: https://github.com/sinatra-in-the-shell/NanoTwitter
* Heroku: https://nano-twitter-sits.herokuapp.com/
* Codeship: https://app.codeship.com/sinatra-in-the-shell
