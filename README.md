# PosterJudging
CSCE 431 Project - TAMU Poster Judging


#when you test scores feature use command
DISPLAY=localhost:1.0 xvfb-run cucumber features/scores.feature

#or if you want to test all features together run
DISPLAY=localhost:1.0 xvfb-run cucumber 



#in case you cannot load capybara-webkit
#setup system for install capybara-webkit
#https://www.stefanwienert.de/blog/2015/07/24/how-to-install-capybara-webkit-for-ubuntu-12-dot-04/

#sudo apt-add-repository ppa:ubuntu-sdk-team/ppa
#sudo apt-get update
#sudo apt-get install qt5-default libqt5webkit5-dev qtdeclarative5-dev g++
#sudo apt-get install xvfb
