Feature: Upload Multiple Posters
	In order to easily enter data for every poster entry in the competition 
	As an administrator
	I want to add and/or update multiple posters using an excel file

	Background:
	  Given I am logged in as admin

	Scenario: Add multiple poster entries
		Given I am on the poster add page
		When I upload the file "data.csv"
		Then I should see the message "Import successful"
		And I should see a presenter named "Harshvardhan"
		And I should see a presenter named "Ralph Crosby"
		
	Scenario: Try to upload wrong file type
		Given I am on the poster add page
		When I upload the file "data.txt"
		Then I should see the message "Invalid file extension"
		
	Scenario: File missing on upload
		Given I am on the poster add page
		When I press "commit"
		Then I should see the message "File missing"
		
	Scenario: Update existing poster entries
		Given I am on the poster add page
		And I have poster #1 where the presenter is "Harshvardhan"
		And I have poster #2 where the presenter is "Ralph Crosby"
		And I have poster #3 where the presenter is "Brittany Duncan"
		When I upload the file "data_update.csv"
		Then I should see a poster titled "Processing Big Data Graphs"
		And I should see a poster titled "Quartet Distance Computation"
		And I should see a poster titled "Timing Integrity Check"
