@scores
Feature: Edit scores
    In order to correct the wrong scores
    As a contest administrator
    I want to edit the score for a poster
    Background:
        Given the following users exist:
          |name | company_name| access_code| role |
          |admin| TAMU        | admin      | admin|
        And the following posters exist:
        |number|presenter    |
        | 1    |Harshvardhan |
        And the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
        And I logged in as "admin"
	   Given Judges scored posters as following:
		  |name  |number |scores   |
          | Kelly| 1     |3,5,3,5,3|
          | Sara | 1     |4,5,4,5,4|
	Scenario: Edit score successfully
		Given I am on the view scores page
		When I follow the #1 "See Details"
		Then I should see the following scores table:
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit  |
          | Kelly  |3      |5      |3         |5     |3      |3.800  | Edit  |
		  | Sara   |4      |5      |4         |5     |4      |4.400  | Edit  |
		  |Average |3.500  |5.000  |3.500     |5.000 |3.500  |4.100  |       |
		When   I edit the scores of poster #1
		And I edit the scores given by judge "Kelly"
 	    And I change scores to 5,5,5,4,4
        Then I should be on the show scores page for "1"
       Then I should see the following scores table:
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit  |
          | Kelly  |5      |5      |5         |4     |4      |4.600  | Edit  |
		  | Sara   |4      |5      |4         |5     |4      |4.400  | Edit  |
		  |Average |4.500  |5.000  |4.500     |4.500 |4.000  |4.500  |       |