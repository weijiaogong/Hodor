@scores
Feature: View in-time scores
    In order to know the scores of all posters in-time
    As a contest administrator
    I want to view the score for each presenter updated in-time.
    Background:
        Given the following users exist:
          |name | company_name| access_code| role|
          |admin| TAMU        | admin      | admin|
        And the following posters exist:
        |number|presenter    |
        | 1    |Harshvardhan |
        | 2    |Ralph Crosby |
        And the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
        And I logged in as "admin"
   
    Scenario: No posters has been judged
        Given No posters has been judged
        When  I press "View Scores"
	    Then  I should see the following scores table:
	       |Poster #  |Presenter |Title |Average |Detail     |
	       | 1    |Harshvardhan  |      |-       |See Details|
           | 2    |Ralph Crosby  |      |-       |See Details|
        When I follow the #1 "See Details"
	    Then I should see an empty list
	    
	Scenario: The scores table is updated according to scoring time
		Given  Judges scored posters as following:
		  |name  |number |scores   |
          | Sara | 1     |5,5,5,5,5|
		And   Judge "Sara" set poster 2 as "no_show"
	    When  I press "View Scores"
		Then  I should see the following scores table:
	       |Poster #  |Presenter |Title |Average |Detail     |
	       | 1    |Harshvardhan  |      | 5.000  |See Details|
           | 2    |Ralph Crosby  |      |No Show |See Details|
        When I follow the #1 "See Details"
        Then I should see the following scores table:
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit  |
		  | Sara   |5      |5      |5         |5     |5      |5.000  |       |
		  |Average |-      |-      |-         |-     |-      |5.000  |       |
		When  I am on the view scores page
		When I follow the #2 "See Details"
		Then I should see an empty list
		

	#@javascript	   
	Scenario: The score page is reloaded automatically
		Given No posters has been judged
		When  I press "View Scores"
		Then  I should see the following scores table:
		   |Poster #  |Presenter |Title |Average |Detail     |
           | 1    |Harshvardhan  |      |-       |See Details|
           | 2    |Ralph Crosby  |      |-       |See Details|
		Given    Judges scored posters as following:
		  |name  |number |scores   |
          | Kelly| 1     |3,5,3,5,3|
        When  I am on the view scores page
		Then  I should see the following scores table:
		   |Poster #  |Presenter |Title |Average |Detail     |
	       | 1    |Harshvardhan  |      | 3.800  |See Details|
           | 2    |Ralph Crosby  |      | -      |See Details|