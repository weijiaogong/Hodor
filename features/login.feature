# encoding: utf-8
Feature: Login
  In order to protect data in the IAP Research Competition system
  As an user
  I want restricted access to the system
  
Background: users in database
  Given the following user exist:
    |name  |company_name|access_code|
    |admin |tamu        |admin      | 
    
  Scenario: login as admin
    Given I am on the login page
    When I fill in "session[password]" with "admin"
    And I press "Sign in"
    Then I should be on the admin page
  
  #Scenario: Login with invalid password
   # Given I am signed out
  #  When I log in with invalid user credentials
  #  Then I should get an error message
  
  #Scenario: Login with valid password
   # Given I am signed out
    #When I log in with valid credentials
    #Then I should be greeted 