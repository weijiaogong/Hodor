@summary
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
        And  the following users exist:
        |name  | company_name|access_code|role  |
        | Sara | TAMU        | Sara      | judge|
        Given Judge "Sara" has not scored assigned poster 1
        And  Judge "Sara" has not scored assigned poster 2
        And  Judge "Sara" has not scored assigned poster 3
        And  I logged in as "Sara"
   
    Scenario: Judge who released their unscored posters will be assigned with new posters when coming back 
        When I follow "Sign out"
        Then I should be on the signout confirm page for "Sara"
        When I press "No"
        Then Judge "Sara" should have no scores
        And  I logged in as "Sara"
        Then  I should see an empty table "#assigned_posters_table"
        Then  I should see the following table "#orphan_posters_table":
          |Poster #|Title           |Accept|
		  | 1      |Big Data        |     |
		  | 2      |Graph Theory    |     |
		  | 3      |Wireless Network|     |