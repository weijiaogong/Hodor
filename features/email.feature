Feature: Confirmation email
  As an admin
  I want to send confirmation email to presenters
  So that presenters know their poster details have been submitted successfully
    
  Background:
      
    Given the following users exist:
    | name  | company_name| access_code|role|
    | admin | tamu        | admin      |admin|

    
  Scenario: Send confirmation email
    Given I am on the new poster page
    When I fill in "poster[title]" with "Title"
    And I fill in "poster[presenter]" with "Student"
    And I fill in "poster[advisors]" with "Advisor"
    And I fill in "poster[email]" with "example@example.com"
    And I press "Register"
    And I wait for background jobs to execute
    Then "example@example.com" should receive an email 

    