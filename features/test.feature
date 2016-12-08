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
        
        
    Scenario: I can get another poster if there are posters need judges
		 When I press "Accept Another Poster"
		 Then  I should see the following table "#assigned_posters_table":
          |Poster #|Title           |Average|Grade|
		  | 1      |Big Data        | -     |     |
		  | 2      |Graph Theory    | -     |     |
		  | 3      |Wireless Network| -     |     |
		  | 4      |Algorithm       | -     |     |
		 Then Button disappeared "Accept Another Poster"
