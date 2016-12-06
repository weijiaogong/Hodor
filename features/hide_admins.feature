Feature: Hide admins
    So that the system is more secure
    As a judge,
    I want to not see the admins and the superadmin
    Admins can only see Judges (not other admins and superadmins)
    SuperAdmin can see Admins and Judges.
    
    Background: admin in database
		Given the following users exist:
	    | name          | company_name| access_code     | scores_count | role       |
	    | admin         | tamu        | admin_code      | 0	           | admin      |
	    | superadmin    | tamu        | superadmin_code | 0            | superadmin |
	    | wyh1          |   tamu      | wyh1_code       | 0            | judge      |
	    | wyh2          |   tamu      | wyh2_code       | 0            | judge      |
	    | rock          |   TxAM      | roc2_code       | 0            | non-judge  |
	    
	Scenario: login as superadmin
    	 Given I logged in as "superadmin_code"
    	 Given I press "View Users"
    	 Then  I should see "admin_code"
    	 And   I should see "superadmin_code"
    	 And   I should see "wyh1_code"
    	 And   I should see "wyh2_code"
	 
	Scenario: login as admin
    	 Given I logged in as "admin_code"
    	 Given I press "View Users"
    	 Then  I should see "admin_code"
    	 And   I should not see "superadmin_code"
    	 And   I should see "wyh1_code"
    	 And   I should see "wyh2_code"