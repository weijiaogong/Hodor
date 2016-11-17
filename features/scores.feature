@scores
Feature: View scores
    In order to know the scores of all posters in-time
    As a contest administrator
    I want to view the score for each presenter
    Background:
        Given the following users exist:
          |name | company_name| access_code| role |
          |admin| TAMU        | admin      | admin|
        And the following posters exist:
        |number|presenter    | title           |
        | 1    |Harshvardhan | Big Data        |
        | 2    |Ralph Crosby | Graph Theory    |
        | 3    |Bill Gwen    | Wireless Network|
        And the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
        And I logged in as "admin"
   
    Scenario: No posters has been judged
        Given No posters has been judged
        When  I press "View Scores"
	    Then  I should see the following table:
	       |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
	       | 1        |Harshvardhan  | Big Data        |-       |0                   |0                           |See Details|
           | 2        |Ralph Crosby  | Graph Theory    |-       |0                   |0                           |See Details|
           | 3        |Bill Gwen     | Wireless Network|-       |0                   |0                           |See Details|
        When I follow poster #1 "See Details"
	    Then I should see an empty table
	    
	Scenario: The scoring status is updated correctly
		Given  Judges scored posters as following:
		  |name  |number |scores   |
          | Sara | 1     |5,5,5,5,5|
		And   Judge "Sara" set poster 2 as "no_show"
	    When  I press "View Scores"
		Then  I should see the following table:
	       |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
	       | 1        |Harshvardhan  | Big Data        | 5.000  |1                   |1                           |See Details|
           | 2        |Ralph Crosby  | Graph Theory    |No Show |1                   |0                           |See Details|
           | 3        |Bill Gwen     | Wireless Network|-       |0                   |0                           |See Details|

        When I follow poster #1 "See Details"
        Then I should see the following table:
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit   |
		  | Sara   |5      |5      |5         |5     |5      |5.000  |  Edit  |
		  |Average |5.000  |5.000  |5.000     |5.000 |5.000  |5.000  |        |
		When  I am on the view scores page
		When I follow poster #3 "See Details"
		Then I should see an empty table
		

	#@javascript	   
	Scenario: Scores are updated after the page is reloaded
        Given No posters has been judged
		When  I press "View Scores"
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 1        |Harshvardhan  | Big Data        |-       |0                   |0                           |See Details|
           | 2        |Ralph Crosby  | Graph Theory    |-       |0                   |0                           |See Details|
           | 3        |Bill Gwen     | Wireless Network|-       |0                   |0                           |See Details|

		Given    Judges scored posters as following:
		  |name  |number |scores   |
          | Kelly| 1     |3,5,3,5,3|
        When  I am on the view scores page
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
	       | 1        |Harshvardhan  | Big Data        | 3.800  |1                   |1                           |See Details|
           | 2        |Ralph Crosby  | Graph Theory    | -      |0                   |0                           |See Details|
           | 3        |Bill Gwen     | Wireless Network| -      |0                   |0                           |See Details|
           
    @javascript	  
       Scenario: The filter works correctly
		Given  Judges scored posters as following:
		  |name  |number |scores   |
          | Sara | 1     |5,5,5,5,5|
		And   Judge "Sara" set poster 2 as "no_show"
		And   Judge "Kelly" has not scored assigned poster 3
		When  I press "View Scores"
        When I choose "status_all"
        Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 1        |Harshvardhan  | Big Data        |5.000   |1                   |1                           |See Details|
           | 2        |Ralph Crosby  | Graph Theory    |No Show |1                   |0                           |See Details|
           | 3        |Bill Gwen     | Wireless Network|-       |1                   |0                           |See Details|
        When I choose "status_no_show"
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title           |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 2        |Ralph Crosby  | Graph Theory   |No Show |1                   |0                           |See Details|
        When I choose "status_scored"
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title          |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 1        |Harshvardhan  | Big Data      |5.000   |1                   |1                           |See Details|
        When I choose "status_unscored"
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 3        |Bill Gwen     | Wireless Network|-       |1                   |0                           |See Details|
    Scenario: Search poster by poster number
		Given  Judges scored posters as following:
		  |name  |number |scores   |
          | Sara | 1     |5,5,5,5,5|
		And   Judge "Sara" set poster 2 as "no_show"
		And   Judge "Kelly" has not scored assigned poster 3
		When  I press "View Scores"
        When  I fill in "searchquery" with "3"
        And   I press "Search"
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 3        |Bill Gwen     | Wireless Network|-       |1                   |0                           |See Details|    
    Scenario: Search poster by poster title
		Given  Judges scored posters as following:
		  |name  |number |scores   |
          | Sara | 1     |5,5,5,5,5|
		And   Judge "Sara" set poster 2 as "no_show"
		And   Judge "Kelly" has not scored assigned poster 3
		When  I press "View Scores"
        When  I fill in "searchquery" with "Big Data"
        And   I press "Search"
		Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 1        |Harshvardhan  | Big Data        |5.000   |1                   |1                           |See Details|   
        When  I fill in "searchquery" with "Algorithm"
        And   I press "Search"
		Then I should see an empty table
        When  I fill in "searchquery" with " "
        And   I press "Search"
        Then  I should see the following table:
		   |Poster #  |Presenter     |Title            |Average   |# of Judges Assigned|# of Posters Scored by Judge|Detail     |
           | 1        |Harshvardhan  | Big Data        |5.000   |1                   |1                           |See Details|
           | 2        |Ralph Crosby  | Graph Theory    |No Show |1                   |0                           |See Details|
           | 3        |Bill Gwen     | Wireless Network|-       |1                   |0                           |See Details|    