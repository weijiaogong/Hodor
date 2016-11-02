 @summary
 Feature: Overall summary of Presenters
  In order to rank each presenter and determine the winner of the poster contest
  As a contest administrator
  I want to view the average score that each presenter earned from the judges.

 Scenario: No posters exsit
        Given I signed in as admin:
          |name | company_name| access_code|
          |admin| TAMU        | admin      |
        When  I view poster rankings page
	       Then  I should see an empty list
