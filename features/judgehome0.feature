@judgehome
Feature: Assignments of judges
    In order to score posters
    As a contest judge
    I want to see the list of posters need graded in my home page
    Background:
        Given the following posters exist:
        |number|presenter    | title           |
        | 1    |Harshvardhan | Big Data        |
        And  the following users exist:
        |name  | company_name|access_code|role  |
        | Sara | TAMU        | Sara      | judge|
        Given Judge "Sara" has not scored assigned poster 1
        And  I logged in as "Sara"
    @javascript
    Scenario: Judge sign out without unscored posters will not see the dialog
		When I judge poster #1
		And I give new scores 5,5,5,4,4
        When I follow "Sign out" without triggerring dialog
        Then I should be on the login page
        And  I logged in as "Sara"
	    Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
    	  | 1      |Big Data        | 4.600 |     |

    @javascript
    Scenario: Judge who released their unscored posters will not be assigned with new posters when coming back 
        When I follow "Sign out" and press "Yes" within the dialog
        Then I should be on the login page
        And  I logged in as "Sara"
	    Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
    	  | 1      |Big Data        | -     |     |
        
    @javascript
    Scenario: Judge who released their unscored posters will not be assigned with new posters when coming back 
        When I follow "Sign out" and press "No" within the dialog
        And  I logged in as "Sara"
        Then  I should see an empty table "#assigned_posters_table"