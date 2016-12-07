Feature: Poster number limit
  In order to set a poster number limit
  As an administrator
  There are limited number of posters can be imported
  As a student
  I can't signup new poster if the limit is exceded.
  Background: admin in database
		Given the following users exist:
	    | name  | company_name| access_code| scores_count | role  |
	    | admin | tamu        | admin      | 0			  | admin |
	    
	    Given   I logged in as "admin"
		   
	
  Scenario: Add multiple poster entries without exceding the limit
        Given the following events exist: 
	    | day  | month	| year	|	max_poster_number  |
	    | 6	   | 12		| 2016	|	4				   |
        When  I press "View Posters"
		When   I upload the file "data.csv"
		Then   I should see "Import successful"
		And   I should see a presenter named "Harshvardhan"
		And   I should see a presenter named "Ralph Crosby"
  
  Scenario: Add multiple poster entries that exceding the limit
        Given the following events exist: 
	    | day  | month	| year	|	max_poster_number  |
	    | 6	   | 12		| 2016	|	4				   |
        When  I press "View Posters"
		When   I upload the file "data_exced.csv"
		Then   I should see "Error: Exceeding poster limit"
		
  Scenario: Signup new posters without exceding the limit
        Given the following events exist: 
	    | day  | month	| year	|	max_poster_number  |
	    | 6	   | 12		| 2016	|	1				   |
        When I press "Student Signup Page"
        When I fill in "poster[title]" with "Title"
        And I fill in "poster[presenter]" with "Student"
        And I fill in "poster[advisors]" with "Advisor"
        And I fill in "poster[email]" with "e-mail@example.com"
        And I press "Register"
        Then I see "Title was successfully created."

  Scenario: Signup new posters exceding the limit
        Given the following events exist: 
	    | day  | month	| year	|	max_poster_number  |
	    | 6	   | 12		| 2016	|	0				   |
        When I press "Student Signup Page"
        When I fill in "poster[title]" with "Title"
        And I fill in "poster[presenter]" with "Student"
        And I fill in "poster[advisors]" with "Advisor"
        And I fill in "poster[email]" with "e-mail@example.com"
        And I press "Register"
        Then I see "No new poster can be created, please contact admin"
        
