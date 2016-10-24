# encoding: utf-8
Feature: Login
  In order to protect data in the IAP Research Competition system
  As an user
  I want restricted access to the system
  
  Scenario: login as admin
    Given I am currently admin
    And I fill in "Password" with "admin"
    And I press "Log in"
    Then I should see "Admin page"
  
  #Scenario: Login with invalid password
   # Given I am signed out
  #  When I log in with invalid user credentials
  #  Then I should get an error message
  
  #Scenario: Login with valid password
   # Given I am signed out
    #When I log in with valid credentials
    #Then I should be greeted 