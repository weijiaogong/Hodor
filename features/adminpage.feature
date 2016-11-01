Feature: Administration Page
    As a contest administrator
    So that I can perform actions for the contest such as assigning posters to judges, importing contestants to the database, and viewing scores
    I want a page that shows me these options. 
    
    Background:
      Given the following user exist:
    | name  | company_name| access_code|
    | admin | tamu        | admin      | 
    | kelly | tamu-cse    | ab28       |
  
      Given   I log in as admin

    Scenario: Click to reset password
      Given I am on the admin page
      And I press "Reset Password"
      Then I should see "Enter new password: "
      And I should see "Confirm the new password: "
    
    Scenario: Same password entered
      Given I am on the reset page
      And I enter "admin" in "new_pw"
      And I enter "admin" in "confirm_pw"
      And I press "Submit"
      Then I should see "The page you tried to access requires you to log in"
      
    Scenario: Same password entered
      Given I am on the reset page
      And I enter "admin" in "new_pw"
      And I enter "admin" in "confirm_pw"
      And I press "Submit"
      And I enter "admin" in "session_password"
      And I press "Sign in"
      Then I should be on the admin page
      
    Scenario: Different password entered
      Given I am on the reset page
      And I enter "asdf" in "new_pw"
      And I enter "qwerty" in "confirm_pw"
      And I press "Submit"
      Then I should see "Passwords don't match"
    
    Scenario: Add judges
      Given I am on the judge add page
      And I press "Clear"
      And I enter 2 in "number"
      And I press "Generate"
      Then I should see 3 rows in the table
      