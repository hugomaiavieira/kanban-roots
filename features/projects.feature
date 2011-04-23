Feature: Manipulate projects
  As a user
  I want manipulate projects
  In order to organize them

  Scenario: Register new project
    Given I am an authenticated contributor
    And I am on the new project page
    When I fill in "Name" with "name 1"
    And I fill in "Description" with "description 1"
    And I press "Save"
    Then I should see "name 1"
    And I should see "description 1"
    And I should be the project's owner

  Scenario: Try to register projects with erros
    Given I am an authenticated contributor
    And I am on the new project page
    And I press "Save"
    Then I should see "Name can't be blank"
    And I should not have any project

  Scenario: Edit a project
    Given I am an authenticated contributor
    And I have a project
    When I am on the project edit page
    And I fill in "Name" with "Some name"
    And I fill in "Description" with "Any description"
    And I press "Save"
    Then I should see "Some name"
    And I should see "Any description"

  Scenario: Delete project
    Given I am an authenticated contributor
    And the following projects:
      | name   | description   |
      | name 1 | description 1 |
      | name 2 | description 2 |
      | name 3 | description 3 |
      | name 4 | description 4 |
    When I delete the 3rd project
    And I am on the dashboard page
    Then I should see "name 1"
    And I should see "name 2"
    And I should see "name 4"
    And I should not see "name 3"

