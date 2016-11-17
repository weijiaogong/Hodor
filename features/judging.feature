Feature: Judge a Poster
  So that I can accurately review and judge a research poster
  I want to rate a poster based on novelty, utility, difficulty, verbal presentation, and written/graphical presentation using a 1 to 5 scale for each criteria

  
Background: users in database
   Given the following posters exist:
   | number | presenter |   title            | advisors |
   | 1      | John      |   Big data         | Walker   |
   | 2      | David     |   Machine Learning | Thomas   |
   | 3      | Alan      |   Werables         | Alex     |
   And the following users exist:
   | access_code |
   | ab13        |
  And   I logged in as "ab13"
  And   I register with my information
  |name  |company_name|
  | Umair| CSE        |
  Then  I should see 3 posters "Big data", "Machine Learning", "Werables" assigned to "Umair"
   
  Scenario: The judge gives scores in all categories
    When  I judge poster #1
    And   I give scores to the poster in every category and submit
    Then  Return to list of posters
    
  Scenario: The judge does not give scores in all categories
    When  I judge poster #1
    And I do not give scores in all categories and try to submit
    Then I remain on the poster scoring page
    
  Scenario: The presenter does not show up
    When  I judge poster #1
    And I press the no show button
    Then Return to list of posters
    
    