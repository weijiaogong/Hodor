@scores
Feature: View scores
    In order to know the scores of all posters in-time
    As a contest administrator
    I want to view the score for each presenter
  Background:
        Given the following users exist:
          |name | company_name| access_code| role|
          |admin| TAMU        | admin      | admin|
        And  the following posters exist:
        |number|presenter    |
        | 1    |Harshvardhan |
        | 2    |Ralph Crosby |
        And  the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
        And I logged in as "admin"
    
	Scenario: Only scored Posters shown in the ranking list
		Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
		And   Judge "Kelly" has not scored assigned poster 2
	    When  I press "View Poster Rankings"
		Then  I should see the following ranking table:
		  |Rank| 	Presenter| 	Title| 	Avg. Score|
		  | 1  |Harshvardhan |       |  5.000     |