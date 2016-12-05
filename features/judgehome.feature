@judgehome     @javascript
Feature: Assignments of judges
    In order to score posters
    As a contest judge
    I want to see the list of posters need graded in my home page
    Background:
        Given the following posters exist:
        |number|presenter    | title           |
        | 1    |Harshvardhan | Big Data        |
        | 2    |Ralph Crosby | Graph Theory    |
        | 3    |Bill Gwen    | Wireless Network|
        | 4    |Danil Lee    | Algorithm       |
        And  the following users exist:
        |name  | company_name|access_code|role  |
        | Sara | TAMU        | Sara      | judge|
        Given Judge "Sara" has not scored assigned poster 1
        And  Judge "Sara" has not scored assigned poster 2
        And  Judge "Sara" has not scored assigned poster 3
        And  I logged in as "Sara"
    Scenario: I should see 3 unscored posters and be able to judge them
        Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
		  | 1      |Big Data        | -     |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |
		 When I judge poster #1
		 And I give new scores 5,5,5,4,4
		 Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
		  | 1      |Big Data        | 4.600 |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |
    Scenario: I can change scores later
		 When I judge poster #1
		 And I give new scores 5,5,5,4,4
		 When I judge poster #1
		 And I give new scores 5,4,4,4,4
		 Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
		  | 1      |Big Data        | 4.200 |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |

    Scenario: Judge sign out without unscored posters will not see the dialog
		When I judge poster #1
		And I give new scores 5,5,5,4,4
		When I judge poster #2
		And I give new scores 5,5,5,4,4
		When I judge poster #3
		And I give new scores 5,5,5,4,4
        When I follow "Sign out" without triggerring dialog
        Then I should be on the login page
        And  I logged in as "Sara"
	    Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
    	  | 1      |Big Data        | 4.600 |     |
		  | 2      |Graph Theory    | 4.600 |     |
		  | 3      |Wireless Network| 4.600 |     |


    Scenario: Judge who keep their unscored posters see former posters when coming back 
        When I follow "Sign out"
        And  I press "Yes"
        Then I should be on the login page
        And  I logged in as "Sara"
	    Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
    	  | 1      |Big Data        | -     |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |

    Scenario: Judge who released their unscored posters will not be assigned with new posters when coming back 
        When I follow "Sign out"
        And  I press "No"
        And  I logged in as "Sara"
        Then  I should see an empty table "#assigned_posters_table"
        
    @javascript
    Scenario: Judge who cancel the confirm dialog will stay on the page
        When I follow "Sign out"
        And  I press "Cancel"
        Then I should be on the judge page for "Sara"
	    Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
    	  | 1      |Big Data        | -     |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |
