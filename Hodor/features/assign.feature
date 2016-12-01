Feature: Assign judge to Posters
    In order to ensure every poster is judged
    As a judge for the contest
    I want to be assigned 2 - 3 posters randomly
    
    Background:
        Given the following users exist:
        | access_code|
        | ab28       |
        Given I am on the login page
        When I fill in "session[password]" with "ab28"
        And I press "Sign in"
        Then I should be on the register page for "ab28"

    Scenario: Properly filled out form
	    Given the following posters exist:
        |presenter    | title   |
        |Harshvardhan | Big data|
        |Ralph Crosby |Machine Learning|
        |Brittany Duncan|Werables|
        When I fill in "name" with "Steven Bierwagen"
        When I fill in "company" with "..."
        And I press "Register"
        #Then there should be a judge named "Steven Bierwagen" with 3 assigned posters
        Then I should see 3 posters "Big data", "Machine Learning", "Werables" assigned to "Steven Bierwagen"
    Scenario: Missing Name
        When I fill in "company" with "..."
        And I press "Register"
        Then I should see "name & company_name cannot be blank"

    Scenario: Missing Company Name
        When I fill in "name" with "Steven Bierwagen"
        And I press "Register"
        Then I should see "name & company_name cannot be blank"
    
    Scenario: Both fields are blank
        And I press "Register"
        Then I should see "name & company_name cannot be blank"

    Scenario: Poster database empty
        When I fill in "name" with "Steven Bierwagen"
        And I fill in "company" with "..."
        And I press "Register"
        Then I should see "There are no more posters to be assigned."