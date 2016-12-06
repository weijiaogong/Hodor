@scores @javascript
Feature: Edit scores
    In order to correct the wrong scores
    As a contest administrator
    I want to edit the score for a poster
    Background:
        Given the following users exist:
          |name | company_name| access_code| role |
          |admin| TAMU        | admin      | admin|
        And the following posters exist:
        |presenter    |title            |
        |Harshvardhan | Big Data        |
        |Ralph Crosby | Graph Theory    |
        |Bill Gwen     | Wireless Network|
        And the following judges exist:
        |name  | company_name|access_code|
        | Sara | TAMU        | Sara      |
        | Kelly| TAMU        | Kelly     |
        | Bill | TAMU        | Bill      |
        And I logged in as "admin"
	   Given Judges scored posters as following:
		  |name  |number |scores   |
          | Kelly| 1     |3,5,3,5,3|
          | Sara | 1     |4,5,4,5,4|
    
	Scenario: Edit score successfully
		Given I am on the view scores page
		When I follow poster #1 "See Details"
		And I "Edit" the scores given by judge "Kelly"
 	    And I give new scores 5,5,5,4,4
        Then I should be on the show scores page for "1"
       Then I should see the following table "#details_table":
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit  | Delete|
          | Kelly  |5      |5      |5         |4     |4      |4.600  | Edit  | Delete|
		  | Sara   |4      |5      |4         |5     |4      |4.400  | Edit  | Delete|
		  |Average |4.500  |5.000  |4.500     |4.500 |4.000  |4.500  |       |       |


	Scenario: Delete score successfully
		Given I am on the view scores page
		When I follow poster #1 "See Details"
		And I "Delete" the scores given by judge "Kelly"
        Then I should be on the show scores page for "1"
       Then I should see the following table "#details_table":
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit  | Delete|
		  | Sara   |4      |5      |4         |5     |4      |4.400  | Edit  | Delete|
		  |Average |4.000  |5.000  |4.000     |5.000 |4.000  |4.400  |       |       |

	Scenario: Create new score successfully
		Given I am on the view scores page
		When I follow poster #1 "See Details"
		And I create new score for judge "Bill"
        Then I should be on the show scores page for "1"
       Then I should see the following table "#details_table":
          |Judge   |novelty|utility|difficulty|verbal|written|Average| Edit  | Delete|
          | Bill   |-      |-      |-         |-     |-      |-      | Edit  | Delete|
          | Kelly  |3      |5      |3         |5     |3      |3.800  | Edit  | Delete|
		  | Sara   |4      |5      |4         |5     |4      |4.400  | Edit  | Delete|
		  |Average |3.500  |5.000  |3.500     |5.000 |3.500  |4.100  |       |       |

	Scenario: Judge already scored the poster
		Given I am on the view scores page
		When I follow poster #1 "See Details"
		And I create new score for judge "Sara"
        Then I should be on the show scores page for "1"
        Then I should see "Judge Sara is already in the score table"
       
	Scenario: Cannot find the judge
		Given I am on the view scores page
		When I follow poster #1 "See Details"
		And I create new score for judge "Jerry"
        Then I should be on the show scores page for "1"
       Then I should see "Cannot Find Judge Jerry"
