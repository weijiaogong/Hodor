Feature: Poster Registration
  As a presenter
  I want to sign up to present
  So that I can compete in the poster competition
    
  Background:
    Given I have the following posters:
      |number|presenter    |
      | 1    |Harshvardhan |
      | 2    |Ralph Crosby |

  Scenario: Register from Index
    Given I am on the login page
    When I press "Register"
    Then I should be on the poster registration page
    
  Scenario: Register new poster
    Given I am on the new poster page
    When I enter "Student" as name
    And I enter "e-mail@example.com" as email
    And I enter "Poster" as poster
    And I enter "Advisor" as advisor
    And I press "Submit"
    Then I should be on the index
    And I should see "Poster registered"
    
  Scenario: Modify poster
    Given I log in as admin
    And I am on the admin page
    And I press "Edit" for poster 1
    And I enter "e-mail@example.com" as email
    And I press "Submit"
    Then I should be on the admin page
    And I should see "Poster updated"
    And I should see "e-mail@example.com" as email for poster 1
    
  Scenario: Modify non-existent poster
    Given I log in as admin
    And I am on the edit poster page for poster 3
    Then I should be on the admin page
    And I should see "No such poster"
  
  Scenario: Delete poster
    Given I log in as admin
    And I am on the admin page
    And I press "Delete" for poster 1
    Then I should be on the admin page
    And I should see "Poster deleted"
    And I should not see poster 1