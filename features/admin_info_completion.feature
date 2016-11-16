Feature: Admin register
    As an admin
    So that I can be distinguished form other admins
    I want to input my name and company the first time I log in
Background: 
    Given the following users exist:
    | access_code |role |
    | 3957        |admin|
    And I logged in as "3957" for the first time
    Then I should be on the admin_registeration page for "3957"
    

    Scenario: Login as admin fo the first time
        When I fill in "name" with "Kelly Jiang"
        When I fill in "company" with "HIIT"
        And I press "Register"
        Then I should be on the admin page
      
    Scenario: Missing Company Name
        When I fill in "name" with "Steven Bierwagen"
        And I press "Register"
        Then I should see "name & company_name cannot be blank"

    Scenario: Missing Name
        When I fill in "company" with "HIIT"
        And I press "Register"
        Then I should see "name & company_name cannot be blank"