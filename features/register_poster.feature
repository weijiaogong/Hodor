Feature: Poster Registration
  As a presenter
  I want to sign up to present
  So that I can compete in the poster competition
    
  Background:
    Given the following posters exist:
      |presenter    |title|advisors|
      |Harshvardhan |a|a|
      |Ralph Crosby |b|b|
    And the following users exist:
    | name  | company_name| access_code|role|
    | admin | tamu        | admin      |admin|
    And the following events exist: 
	    | day  | month	| year	|	max_poster_number  |
	    | 6	   | 12		| 2016	|	20				   |

#  Scenario: Register from Index  #No longer valid- Admin provides the URL to students
#    Given I am on the login page
#    When I follow "Register"
#    Then I am on the new poster page
    
  Scenario: Register new poster
    Given I am on the new poster page
    When I fill in "poster[title]" with "Title"
    And I fill in "poster[presenter]" with "Student"
    And I fill in "poster[advisors]" with "Advisor"
    And I fill in "poster[email]" with "e-mail@example.com"
    And I press "Register"
    Then I see "Title was successfully created."
    
  Scenario: Register part of poster
    Given I am on the new poster page
    When I fill in "poster[title]" with "Title"
    And I press "Register"
    Then I see "Please correct the following fields: presenter, email, advisors"
    
  Scenario: Modify poster
    Given I logged in as "admin"
    And I am on the poster add page
    And I edit poster 1
    And I fill in "poster[email]" with "e-mail@example.com"
    And I press "Save changes"
    Then I see "was successfully updated."
    And I see "e-mail@example.com" as "email" for poster 1
    
  Scenario: Add poster as admin
    Given I logged in as "admin"
    And I am on the new poster page
    When I fill in "poster[title]" with "Title"
    And I fill in "poster[presenter]" with "Student"
    And I fill in "poster[advisors]" with "Advisor"
    And I fill in "poster[email]" with "e-mail@example.com"
    And I press "Register"
    Then I see "Title was successfully created."
    And I should be on the poster add page
    
  Scenario: Modify part of poster
    Given I logged in as "admin"
    And I am on the poster add page
    And I edit poster 1
    And I fill in "poster[email]" with ""
    And I press "Save changes"
    Then I see "Please correct the following fields: email"
    
  Scenario: Modify non-existent poster
    Given I logged in as "admin"
    And I edit poster 3
    Then I see "No such poster"
  
  Scenario: Delete poster
    Given I logged in as "admin"
    And I am on the poster add page
    And I delete poster 1
    Then I see "Poster deleted"
    And I do not see poster 1