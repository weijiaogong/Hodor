@scores
Feature: View in-time scores
    In order to know the scores of all posters in-time
    As a contest administrator
    I want to view the score for each presenter updated in-time.
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
        When  I view scores page
	    Then  I should see an empty list
	    
	Scenario: The scores table is updated according to scoring time
		Given  Judges scored posters as following:
		  |name  |number |scores   |
          | Sara | 1     |5,5,5,5,5|
		And   Judge "Sara" set poster 2 as "no_show"
	    When  I view scores page
		Then  I should see the following scores table:
		  |Poster #|Novelty|Utility|Difficulty|Verbal|Written|No Show?|Judge  |
		  |1       |5      |5      |5         |5     |5      |Here    |Sara   |
		  |2       |-      |-      |-         |-     |-      |Not Here|Sara   |
	@javascript	   
	Scenario: The score page is reloaded automatically
		Given No posters has been judged
		And   I am on view scores page
		Then  I should see an empty list
		Given    Judges scored posters as following:
		  |name  |number |scores   |
          | Kelly| 1     |3,5,3,5,3|
		Then  I should see the following scores table:
		  |Poster #|Novelty|Utility|Difficulty|Verbal|Written|No Show?|Judge  |
		  |1       |3      |5      |3         |5     |3      |Here    |Kelly  |