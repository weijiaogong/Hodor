Feature: Limit incorrect posters
    As a judge
    So that I can't judge posters that I'm not supposed to judge currently
    I want to be redirected to the main judging page if I try to judge a poster I'm not assigned to
    Background:
        Given the following users exist:
          |name | company_name| access_code| role|
          |admin| TAMU        | admin      | admin|
        And the following posters exist:
        |number|presenter    | title |
        | 1    |Harshvardhan | A     |
        | 2    |Ralph Crosby | B     |
        | 3    |cccccccccccc | C     |
        | 4    |dddddddddddd | D     |
        And the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
    And I logged in as "Sara"
        
    Scenario: Posters can be rescored
		Given Judges scored posters as following:
		|name  |number |scores   |
        | Sara | 1     |5,5,5,5,5|
        | Sara | 2     |4,4,4,4,4|
	    Then  I try to visit judges one posters one judge?
		Then  I can judge poster one
		
	Scenario: Posters was not assigned to the judge
		Given Judges scored posters as following:
		|name  |number |scores        |
        | Sara | 1     |5,5,5,5,5     |
        | Sara | 2     |4,4,4,4,4     |
        | Sara | 3     |-1,-1,-1,-1,-1|
	   # Then  I try to visit judges 1 posters 4 judge?
	    Then  I try to visit judges one posters four judge?
		Then  I should be on the judge page for "Sara"
		