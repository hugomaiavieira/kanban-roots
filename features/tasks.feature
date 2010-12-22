Feature: Manipulate tasks
  As a user
  I want manipulate tasks
  In order to organize them

  Scenario: Register task successfully
    Given I am a contributor of "Sgtran" project
    And I am on the "Sgtran" tasks page
    When I follow "New Task"
    And I fill in "Title" with "Create issues"
    And I fill in "Description" with "Create issues for kanban-roots project"
    And I select "5" from "Points"
    And I select "Feature" from "Category"
    And I select "" from "Position"
    And I press "Save"
    Then I should see "Create issue"
    And I should see "Create issues for kanban-roots project"
    And I should see "5"
    And I should see "Feature"
    And I should see "Backlog"
    And "Sgtran" project should have "1" task

  Scenario: Try to register tasks with errors
    Given I am a contributor of "Sgtran" project
    And I am on the "Sgtran" tasks page
    When I follow "New Task"
    When I fill in "Title" with ""
    And I press "Save"
    Then I should see "Title can't be blank"

  Scenario: Edit a task
    Given I have a task of "Sgtran" project
    When I am on the task edit page
    And I fill in "Title" with "Close issue"
    And I press "Save"
    Then I should see "Close issue"

