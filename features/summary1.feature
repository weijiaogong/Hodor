@summary
Feature: Overall summary of Presenters
    In order to rank each presenter and determine the winner of the poster contest
    As a contest administrator
    I want to view the average score that each presenter earned from the judges.
    Background:
        Given the following users exist:
          |name | company_name| access_code| role|
          |admin| TAMU        | admin      | admin|
        And  the following posters exist:
        |presenter    |
        |Harshvardhan |
        |Ralph Crosby |
        And  the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
        And I logged in as "admin"
    Scenario: No posters has been judged
        Given No posters has been judged
        When  I press "View Poster Rankings"
	    Then  I should see an empty table
	    
   Scenario: Posters are ranked according to their average score
		Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
		  
	    When  I press "View Poster Rankings"
		Then  I should see the following ranking table:
		  |Rank| 	Presenter| 	Title| 	Avg. Score|
		  | 1  |Harshvardhan |       |  5.000     |
		  | 2  |Ralph Crosby |       |  4.000     |
		
	Scenario: Rankings are updated according to their average score
 	    Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
        | Kelly| 1     |3,3,3,3,3|
        | Kelly| 2     |5,5,5,5,5|
	    When  I press "View Poster Rankings"
		Then   I should see the following ranking table:
		  |Rank| 	Presenter| 	Title| 	Avg. Score|
		  | 1  |Ralph Crosby |       |  4.500     |
		  | 2  |Harshvardhan |       |  4.000     |

	Scenario: download the ranking file
		Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
	    When  I press "View Poster Rankings"
	    And   I press "Download"
		Then   I see a popup window for download