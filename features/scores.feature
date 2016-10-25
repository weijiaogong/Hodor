@scores
Feature: View in-time scores
    In order to know the scores of all posters in-time
    As a contest administrator
    I want to view the score for each presenter updated in-time.
    Background:
        Given I signed in as admin
        And   I have poster 1 where the presenter is "Harshvardhan"
        And   I have poster 2 where the presenter is "Ralph Crosby"
        And   I have one judge named "Sara" with access code "Sara"
        And   I have one judge named "Kelly" with access code "Kelly"
   
    Scenario: No posters has been judged
        Given No posters has been judged
        When  I view scores page
	    Then  I should see an empty list
	    
	Scenario: The scores table is updated according to scoring time
		Given Judge "Sara" scored poster 1 as "5,5,5,5,5"
		And   Judge "Sara" set poster 2 as "no_show"
	    When  I view scores page
		Then  I should see the following scores table:
		 #|Poster #|Novelty|Utility|Difficulty|Verbal|Written|No Show?|Judge  |
		  |1       |5      |5      |5         |5     |5      |Here    |Sara   |
		  |2       |-      |-      |-         |-     |-      |Not Here|Sara   |
	@javascript	   
	Scenario: The score page is reloaded automatically
		Given No posters has been judged
		Then  I should see an empty list
		Given  Judge "Kelly" scored poster 1 as "3,5,3,5,3"
		When  The page is reloaded
		Then  I should see the following scores table:
		 #|Poster #|Novelty|Utility|Difficulty|Verbal|Written|No Show?|Judge  |
		  |1       |3      |5      |3         |5     |3      |Here    |Kelly  |