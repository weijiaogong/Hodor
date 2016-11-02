@summary
Feature: Overall summary of Presenters
    In order to rank each presenter and determine the winner of the poster contest
    As a contest administrator
    I want to view the average score that each presenter earned from the judges.
    Background:
        Given I signed in as admin:
          |name | company_name| access_code|
          |admin| TAMU        | admin      |
        And   I have the following posters:
        |number|presenter    |
        | 1    |Harshvardhan |
        | 2    |Ralph Crosby |
        And   I have the following judges:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
   
    Scenario: No posters has been judged
        Given No posters has been judged
        When  I view poster rankings page
	    Then  I should see two posters with average score 0.000
	    
   Scenario: Posters are ranked according to their average score
		Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
		  
	    When  I view poster rankings page
		Then  I should see the following ranking table:
		  |Rank| 	Presenter| 	Title| 	Avg. Score|
		  | 1  |Harshvardhan | test  |  5.000     |
		  | 2  |Ralph Crosby | test  |  4.000     |
		
	Scenario: Rankings are updated according to their average score
 	    Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
        | Kelly| 1     |3,3,3,3,3|
        | Kelly| 2     |5,5,5,5,5|
	    When  I view poster rankings page
		Then   I should see the following ranking table:
		  |Rank| 	Presenter| 	Title| 	Avg. Score|
		  | 1  |Ralph Crosby |test |  4.500     |
		  | 2  |Harshvardhan |test |  4.000     |

	Scenario: download the ranking file
		Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
	    When  I view poster rankings page
	    And   I click on download button
		Then   I see a popup window for download