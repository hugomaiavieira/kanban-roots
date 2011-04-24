Feature: Use the board
  As a user
  I want use the board
  In order see, move and manipulate the taks of my project

  Scenario: Clean up Done tasks
    Given I am an authenticated contributor
    And I have a project
    And the following tasks:
      | title  | position |
      | task 1 | Doing    |
      | task 2 | Done     |
      | task 3 | Done     |
      | task 4 | Done     |
    When I am on the projects board page
    And I follow "Clean up Done"
    Then I should see "Done division was cleaned up."
    And the Done division should be cleaned

  Scenario: See the category legend on the board, ordered by name
    Given I am an authenticated contributor
    And I have a project
    And the following categories:
      | name        | color  |
      | Feature     | ffffff |
      | Refactoring | fff000 |
      | Bug         | 000fff |
    When I am on the projects board page
    Then I should see "Legend: None Bug Feature Refactoring"


  @javascript
  Scenario: Drag and drop a task to another board position
    Given I am an authenticated contributor
    And I have a project
    And the following tasks:
      | title  | position |
      | task 1 | Doing    |
      | task 2 | Done     |
    And I am on the projects board page
    When I drag "task 1" task to "Done" position
    Then I should see "task 1" task at "Done" position

