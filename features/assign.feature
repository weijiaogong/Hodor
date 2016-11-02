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
        When I fill in "session[password]" with "ab12"
        And I press "Sign in"
        Then I should be on the register page for "ab12"

    
    Scenario: Properly filled out form
	    Given I have the following posters:
        |number|presenter    |
        | 1    |Harshvardhan |
        | 2    |Ralph Crosby |
        | 3    |Brittany Duncan|
        When I fill in Name with "Steven Bierwagen"
        When I fill in Company Name with "..."
        And I click "Register"
        Then there should be a judge named "Steven Bierwagen" with 3 assigned posters
    
    Scenario: Missing Name
        When I fill in Company Name with "..."
        And I click "Register"
        Then I should see the message "name & company_name cannot be blank"

    Scenario: Missing Company Name
        When I fill in Name with "Steven Bierwagen"
        And I click "Register"
        Then I should see the message "name & company_name cannot be blank"
    
    Scenario: Both fields are blank
        And I click "Register"
        Then I should see the message "name & company_name cannot be blank"

    Scenario: Poster database empty
        Given poster database is empty
        When I fill in Name with "Steven Bierwagen"
        And I fill in Company Name with "..."
        And I click "Register"
        Then I should see the message "There are no more posters to be assigned."