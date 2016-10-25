@summary
Feature: Overall summary of Presenters
    In order to rank each presenter and determine the winner of the poster contest
    As a contest administrator
    I want to view the average score that each presenter earned from the judges.
    Background:
        Given I signed in as admin
        And   I have poster 1 where the presenter is "Harshvardhan"
        And   I have poster 2 where the presenter is "Ralph Crosby"
        And   I have one judge named "Sara" with access code "Sara"
        And   I have one judge named "Kelly" with access code "Kelly"
   
    Scenario: No posters has been judged
        Given No posters has been judged
        When  I view poster rankings page
	    Then  I should see two posters with average score 0.000
	    
    Scenario: Posters are ranked according to their average score
		Given Judge "Sara" scored poster 1 as "5,5,5,5,5"
		And   Judge "Sara" scored poster 2 as "4,4,4,4,4"
	    When  I view poster rankings page
		Then  I should see presenter named "Harshvardhan" ranked 1 with average score 5.000
		And   I should see presenter named "Ralph Crosby" ranked 2 with average score 4.000
		
	Scenario: Rankings are updated according to their average score
 	    Given Judge "Sara" scored poster 1 as "5,5,5,5,5"
		And   Judge "Sara" scored poster 2 as "4,4,4,4,4"
		And   Judge "Kelly" scored poster 1 as "3,3,3,3,3"
		And   Judge "Kelly" scored poster 2 as "5,5,5,5,5"
	    When  I view poster rankings page
		Then  I should see presenter named "Ralph Crosby" ranked 1 with average score 4.500
		And   I should see presenter named "Harshvardhan" ranked 2 with average score 4.000
		
	Scenario: download the ranking file
		Given Judge "Sara" scored poster 1 as "5,5,5,5,5"
		And   Judge "Sara" scored poster 2 as "4,4,4,4,4"
	    When  I view poster rankings page
	    And   I click on download button
		Then   I see a popup window for download