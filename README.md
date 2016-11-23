# PosterJudging
CSCE 431 Project - TAMU Poster Judging

## Installation

Run rake secret to generate a new token.

Now create config/initializers/secret_token.rb with the following contents:

`PosterJudging::Application.config.secret_key_base = '<token>'`

Replace with the one you just generated.

*Do not commit this file to the repo* (Or git rm it if it's in your repo still)

## Fixing attribute errors
If posters is missing the no_show field, run `rake db:reset`

## Testing
### To test a particular feature \<feature\>, run
`DISPLAY=localhost:1.0 xvfb-run cucumber features/<feature>.feature`

### To test all features together run
`DISPLAY=localhost:1.0 xvfb-run cucumber`

### In case you cannot load capybara-webkit during bundle install, follow the instructions [here](https://www.stefanwienert.de/blog/2015/07/24/how-to-install-capybara-webkit-for-ubuntu-12-dot-04/)

`sudo apt-add-repository ppa:ubuntu-sdk-team/ppa
sudo apt-get update
sudo apt-get install qt5-default libqt5webkit5-dev qtdeclarative5-dev g++
sudo apt-get install xvfb`


### If you have trouble in bundle install

`gem cleanup --dryrun
gem uninstall -aIx
gem install bundler
delete Gemfile.lock
bundle install
sudo service postgresql start`


### Making sure the auto_emailer is set up properly

After pushing to heroku we need to setup username and password for the mailer

'heroku config:set email=myemail@example.com password=mypassword'

check if the background workers are running using 

'heroku ps'

if it shows a line with worker then its running if it shows web then we need to add a worker using the command below

'heroku ps:scale worker=1'

check background worker again (using heroku ps), it should show worker.