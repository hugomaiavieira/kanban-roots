Feature: Authentication

  Scenario: Sign out
    Given I am an authenticated contributor
    And I am on my details page
    When I follow "Sign out"
    Then I should see "Sign in"

