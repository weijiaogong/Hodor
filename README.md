# PosterJudging
CSCE 431 Project - TAMU Poster Judging

########################## Installation #######################################
Run `rake secret` to generate a new token.

Now create config/initializers/secret_token.rb with the following contents:

`PosterJudging::Application.config.secret_key_base = '<token>'`

Replace <token> with the one you just generated.

*Do not commit this file to the repo*

########################## test #######################################
#when you test scores feature use command
DISPLAY=localhost:1.0 xvfb-run cucumber features/scores.feature

#or if you want to test all features together run
DISPLAY=localhost:1.0 xvfb-run cucumber 



#in case you cannot load capybara-webkit during bundle install
#setup system for install capybara-webkit
#https://www.stefanwienert.de/blog/2015/07/24/how-to-install-capybara-webkit-for-ubuntu-12-dot-04/

#sudo apt-add-repository ppa:ubuntu-sdk-team/ppa
#sudo apt-get update
#sudo apt-get install qt5-default libqt5webkit5-dev qtdeclarative5-dev g++
#sudo apt-get install xvfb


##########################  if you have trouble in bundle install #######################################

1. gem cleanup --dryrun
2. gem uninstall -aIx
3. gem install bundler
4. delete Gemfile.lock
5. bundle install
6. sudo service postgresql start 
