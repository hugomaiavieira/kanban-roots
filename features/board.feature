Feature: Use the board
  As a user
  I want use the board
  In order see, move and manipulate the taks of my project

  Scenario: Show the board
    Given I am an authenticated contributor
    And I have a project
    And the following tasks:
      | title  | position |
      | task 1 | Backlog  |
      | task 2 | To Do    |
      | task 3 | Backlog  |
      | task 4 | Backlog  |
      | task 5 | Doing    |
      | task 6 | To Do    |
      | task 7 | Done     |
      | task 8 | Doing    |
      | task 9 | Done     |
    When I am on the projects board page
    Then I should see a board like this:
      | Backlog                     | To Do                       | Doing                       | Done                        |
      | task 1\n  \n    Set sponsor | task 2\n  \n    Set sponsor | task 5\n  \n    Set sponsor | task 7\n  \n    Set sponsor |
      | task 3\n  \n    Set sponsor | task 6\n  \n    Set sponsor | task 8\n  \n    Set sponsor | task 9\n  \n    Set sponsor |
      | task 4\n  \n    Set sponsor |                             |                             |                             |

