@judgehome
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
		 And  I should see the following table "#orphan_posters_table":
          |Poster #|Title           |Accept|
		  | 4      |Algorithm       |      |
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
    Scenario: Judge can accept new poster and grade it from list of orphan posters 
        When  I accept poster #4 from  table "#orphan_posters_table"
        And I give new scores 5,5,5,4,4
        Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
		  | 1      |Big Data        | -     |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |
		  | 4      |Algorithm       | 4.600 |     |
		And  The grade button for poster #4 in table "#assigned_posters_table" should be enabled
    Scenario: Judge can leave at any time and keep their unscored posters
        When I follow "Sign out"
        #Then I should be on the signout confirm page for "Sara"
        #When I press "Yes"
        And  I logged in as "Sara"
        Then I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
		  | 1      |Big Data        | -     |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |
		And  I should see the following table "#orphan_posters_table":
          |Poster #|Title           |Accept|
		  | 4      |Algorithm       |      |
    
    #Scenario: Judge can leave at any time and release their unscored posters
        #When I follow "Sign out"
        #Then I should be on the signout confirm page for "Sara"
        #When I press "No"
        #Then Judge "Sara" should have no scores
        #And  I logged in as "Sara"
        #Then  I should see an empty table "#assigned_posters_table"