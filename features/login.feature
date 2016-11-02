# encoding: utf-8
Feature: Login
  In order to protect data in the IAP Research Competition system
  As an user
  I want restricted access to the system
  
Background: users in database
  Given the following users exist:
    | name  | company_name| access_code|
    | admin | tamu        | admin      | 
    | kelly | tamu-cse    | ab28       | 

  And the following users exist:
   | access_code |
   | ab12        |
   | ab13        |
    
  And I am on the login page
  Scenario: login as admin
    When I fill in "session[password]" with "admin"
    And I press "Sign in"
    Then I should be on the admin page
  
  Scenario: login as judge after first time
    When I fill in "session[password]" with "ab28"
    And I press "Sign in"
    Then I should be on the judge page for "kelly"
  
  Scenario: invaild password-sadpass
    When I fill in "session[password]" with "1234"
    And I press "Sign in"
    #Then I should see "Invalid password" password error reminder
    Then I should see "Invalid password"
  Scenario: login as judge at first time
    When I fill in "session[password]" with "ab13"
    And I press "Sign in"
    Then I should be on the register page for "ab13"
    
  #Scenario: Login with invalid password
   # Given I am signed out
  #  When I log in with invalid user credentials
  #  Then I should get an error message
  
  #Scenario: Login with valid password
   # Given I am signed out
    #When I log in with valid credentials
    #Then I should be greeted 