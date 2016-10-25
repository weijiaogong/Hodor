Feature: Judge a Poster
  So that I can accurately review and judge a research poster
  I want to rate a poster based on novelty, utility, difficulty, verbal presentation, and written/graphical presentation using a 1 to 5 scale for each criteria

  
Background: users in database
  Given the following poster exist:
   | number | presenter |   title            | advisors |
   | 1      | John      |   Big data         | Walker   |
   | 2      | David     |   Machine Learning | Thomas   |
   | 3      | Alan      |   Werables         | Alex     |
  
  
  Given the following user exist:
    | name  | company_name| access_code|
    | admin | tamu        | admin      | 
    |       |             | ab28       | 
    
  
  Given the following access_code exist:
   | access_code |
   | ab12        |
   | ab13        |
   
  Scenario: The judge gives scores in all categories
    Given I am on the login page
    Given I fill in "session[password]" with "ab13" and press Sign in 
    Given I fill in my information
    Given I am on the poster scoring page
    And I give scores to the poster in every category and submit
    Then Return to list of posters
    
  Scenario: The judge does not give scores in all categories
    Given I am on the login page
    Given I fill in "session[password]" with "ab13" and press Sign in 
    Given I fill in my information
    Given I am on the poster scoring page
    And I do not give scores in all categories and try to submit
    Then I remain on the poster scoring page
    
  Scenario: The presenter does not show up
    Given I am on the login page
    Given I fill in "session[password]" with "ab13" and press Sign in 
    Given I fill in my information
    Given I am on the poster scoring page
    And I press the no show button
    Then Return to list of posters
    
    