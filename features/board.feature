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
    Then I should see "Legend:NoneBugFeatureRefactoring"

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


  Scenario: Positions shows the points at their titles
    Given I am an authenticated contributor
    And I have a project
    And the following tasks:
      | title  | position | points |
      | task 1 | To Do    | 5      |
      | task 2 | Doing    | 3      |
      | task 3 | Done     | 4      |
    And I am on the projects board page
    Then I should see "To Do (5)"
    And I should see "Doing (3)"
    And I should see "Done (4)"


  @javascript
  Scenario: Changing tasks from a position to another updates the position points
    Given I am an authenticated contributor
    And I have a project
    And the following tasks:
      | title  | position | points |
      | task 1 | Backlog  | 5      |
      | task 2 | Backlog  | 3      |
    And I am on the projects board page
    When I drag "task 1" task to "To Do" position
    Then I should see "To Do (5)"
    When I drag "task 2" task to "To Do" position
    Then I should see "To Do (8)"
    When I drag "task 2" task to "Doing" position
    Then I should see "To Do (5)"
    And I should see "Doing (3)"
    When I drag "task 2" task to "Done" position
    Then I should see "Doing (0)"
    And I should see "Done (3)"

