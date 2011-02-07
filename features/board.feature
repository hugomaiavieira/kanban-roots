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

# XXX: Look for a way to test it!

#  Scenario: Show the board
#    Given I am an authenticated contributor
#    And I have a project
#    And the following tasks:
#      | title  | position |
#      | task 1 | Backlog  |
#      | task 2 | To Do    |
#      | task 3 | Backlog  |
#      | task 4 | Backlog  |
#      | task 5 | Doing    |
#      | task 6 | To Do    |
#      | task 7 | Done     |
#      | task 8 | Doing    |
#      | task 9 | Done     |
#    When I am on the projects board page
#    Then I should see a board like this:
#      | Backlog | To Do  | Doing  | Done   |
#      | task 1  | task 2 | task 5 | task 7 |
#      | task 3  | task 6 | task 8 | task 9 |
#      | task 4  |        |        |        |

