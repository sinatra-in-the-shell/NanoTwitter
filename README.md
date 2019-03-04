# NanoTwitter V0.3
* Course project for Cosi105b - Software Engineering for Scalability.
* Implement an SNS website including most basic funtions of Twitter. Use [Sinatra](http://sinatrarb.com/) + [React](https://reactjs.org/) as primary tech tools.

## Team Member
* Fengzhencheng Zeng fzeng@brandeis.edu
* Ziyu Liu ziyuliu@brandeis.edu
* Yirun Zhou yirunzhou@brandeis.edu

## To Build and Run
Ruby, bundler, npm/yarn, postgresql is required to be installed first.

### Build
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

## Deployment:
The project is hooked to Codeship and deployed on [Heroku](https://nano-twitter-sits.herokuapp.com/).

## Documentations:
* [Route](/doc/ROUTE.md)
* [Schema](/doc/SCHEMADB.md)

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
* Set up Codeship auto testing and deployment (on Heroku).
* Designed [NanoTwitter API 1.0](https://app.swaggerhub.com/apis-docs/sinatra-in-the-shell/nano-twitter-api/1.0.0).(**Not implemented yet.**)
* Added unittests on the server side of register/login/authenticate.
* *TODO*: Implement test interface.