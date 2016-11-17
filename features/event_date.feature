Feature: Set event date
  So that the app can automatically send a reminder to presenters 24-hours before the event
  
  Background: admin in database
		Given the following users exist:
	    | name  | company_name| access_code| scores_count | role  |
	    | admin | tamu        | admin      | 0			  | admin |
		
		Given   I logged in as "admin"
		
  Scenario: Update event date
		When   I update the event date with a new date
		Then   I should see the new date for the event on the admin page
