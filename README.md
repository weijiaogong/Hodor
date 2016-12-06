# PosterJudging
CSCE 606 Project - TAMU Poster Judging

## Installation

### Database
Install postgresql and then run:

```shell
gem install postgres
sudo service postgresql start
```

If postgres reports an error "new encoding (UTF8) is incompatible with the encoding of the template database", [do the following](http://stackoverflow.com/a/16737776):

```shell
psql
UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
DROP DATABASE template1;
CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
\c template1
VACUUM FREEZE;
```

Set up the database with 

```shell
rake db:setup
rake db:migrate
rake db:seed
```

### Application secrets

Run rake secret to generate a new token.

Now create config/initializers/secret_token.rb with the following contents:

`PosterJudging::Application.config.secret_key_base = '<token>'`

Replace with the one you just generated.

*Do not commit this file to the repo* (Or git rm it if it's in your repo still). This secret would enable someone to spoof the site with the same sessions if shared.

### Setting up Heroku
You will need to connect your git repo to the Heroku instance:

`heroku git:remote -a iap-poster-app`

If you are making a new Heroku instance, run

```shell
heroku create
heroku run rake rails:update:bin
```

When you are ready to deploy, run
`git push heroku master`

### Setting up auto-emailer

After pushing to heroku, we need to setup username and password for the mailer.

`heroku config:set email=<myemail@example.com> password=<mypassword>`

Check if the background workers are running using 

`heroku ps`

If it shows a line with worker then it's running if it shows web then we need to add a worker using the command below

`heroku ps:scale worker=1`

Check background worker again (using heroku ps), it should show worker.

## Testing
### To test a particular feature \<feature\>, run
`DISPLAY=localhost:1.0 xvfb-run cucumber features/<feature>.feature`

### To test all features together run
`DISPLAY=localhost:1.0 xvfb-run cucumber`

### In case you cannot load capybara-webkit during bundle install, follow the instructions [here](https://www.stefanwienert.de/blog/2015/07/24/how-to-install-capybara-webkit-for-ubuntu-12-dot-04/)

```shell
sudo apt-add-repository ppa:ubuntu-sdk-team/ppa
sudo apt-get update
sudo apt-get install qt5-default libqt5webkit5-dev qtdeclarative5-dev g++
sudo apt-get install xvfb
```

### If you have trouble in bundle install

```shell
gem cleanup --dryrun
gem uninstall -aIx
gem install bundler
delete Gemfile.lock
bundle install
sudo service postgresql start
```