Feature: Upload Multiple Posters
	In order to easily enter data for every poster entry in the competition 
	As an administrator
	I want to add and/or update multiple posters using an excel file

	Background: admin in database
		Given the following users exist:
	    | name  | company_name| access_code| scores_count | role  |
	    | admin | tamu        | admin      | 0			  | admin |
		
		Given   I logged in as "admin"
		Given   I press "View Posters"

	Scenario: Add multiple poster entries
		When   I upload the file "data.csv"
		Then   I should see "Import successful"
		And   I should see a presenter named "Harshvardhan"
		And   I should see a presenter named "Ralph Crosby"
		
	Scenario: Try to upload wrong file type
		When   I upload the file "data.txt"
		Then   I should see "Invalid file extension"
		
	Scenario: File missing on upload
		When   I press "Import"
		Then   I should see "File missing"

	Scenario: Update existing poster entries
	   Given  the following posters exist:
        |presenter      |
        |Harshvardhan   |
        |Ralph Crosby   |
        |Brittany Duncan|
		When   I upload the file "data_update.csv"
		Then   I should see a poster titled "Processing Big Data Graphs"
		And   I should see a poster titled "Quartet Distance Computation"
		And   I should see a poster titled "Timing Integrity Check"
	
	Scenario: Upload malformed file
		When I upload the file "data_wrong.csv"
		Then I should see "Invalid column header"
		
	Scenario: Upload partial columns
	  When I upload the file "data_missing_column.csv"
	  Then I should see "Missing column header"
		
	Scenario: Clear posters
	  When I press "Clear"
	  Then I should be on the admin poster page
	  And I should see 0 rows in the table
	  
	Scenario: Download posters
	  Given  the following posters exist:
        |presenter      |
        |Harshvardhan   |
        |Ralph Crosby   |
        |Brittany Duncan|
	  When I press "Download"
	  Then the file app/downloads/posters.csv contains
		"""
		presenter,title,advisors,email
		Harshvardhan,,,
		Ralph Crosby,,,
		Brittany Duncan,,,
		
		"""