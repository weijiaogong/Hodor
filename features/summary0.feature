 @summary
 Feature: Overall summary of Presenters
  In order to rank each presenter and determine the winner of the poster contest
  As a contest administrator
  I want to view the average score that each presenter earned from the judges.

 Scenario: No posters exsit
        Given the following users exist:
          |name | company_name| access_code| role|
          |admin| TAMU        | admin      | admin|
        Given I logged in as "admin"
        When  I press "View Poster Rankings"
	       Then  I should see an empty list
