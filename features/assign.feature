Feature: Assign judge to Posters
    In order to ensure every poster is judged
    As a judge for the contest
    I want to be assigned 2 - 3 posters randomly
    
    Background:
        Given the following user exist:
    | name  | company_name| access_code|
    | admin | tamu        | admin      | 
    | kelly | tamu-cse    | ab28       | 
    
  
        Given the following access_code exist:
  | access_code |
  | ab12        |
  | ab13        |
        Given I am on the login page
        When I fill in "session[password]" with "ab28"
        And I press "Sign in"
        Given I am on the judge registration page for "ab28"
        # And I am logged in as admin

    
    Scenario: Properly filled out form
	Given there are 3 posters in the database
        When I fill in Name with "Steven Bierwagen"
        When I fill in Company Name with "..."
        And I click "Register"
        Then there should be a judge named "Steven Bierwagen" with 3 assigned posters
    
    Scenario: Missing Name
        When I fill in Company Name with "..."
        And I click "Register"
        Then I should see the message "Missing: name"

    Scenario: Missing Company Name
        When I fill in Name with "Steven Bierwagen"
        And I click "Register"
        Then I should see the message "Missing: company"
    
    Scenario: Both fields are blank
        And I click "Register"
        Then I should see the message "Missing: name, company"

    Scenario: Poster database empty
        When I fill in Name with "Steven Bierwagen"
        And I fill in Company Name with "..."
        And I click "Register"
        Then I should see the message "There are no more posters to be assigned."