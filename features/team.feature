Feature: Manipulate teams
  As a user
  I want manipulate the teams
  In order to organize easier the contributors of the projects

  Scenario: Register team successfully
    Given I am on the new team page
    When I fill in "Name" with "Owners"
    And I press "Save"
    Then I should see "Owners"
    And I should see "Team was successfully created."

  Scenario: Register team with errors
    Given I am on the new team page
    When I fill in "Name" with ""
    And I press "Save"
    And I should see "Name can't be blank"

  Scenario: Add conributors
    Given I have a team
    And I have a contributor named "Hugo Maia Vieira"
    And I have a contributor named "Rodrigo Manhães"
    And I am on the team page
    When I follow "Manage contributors"
    When I select "Hugo Maia Vieira" from "Contributors"
    And I select "Rodrigo Manhães" from "Contributors"
    And I press "Save"
    Then I should see "Hugo Maia Vieira and Rodrigo Manhães"
    And I should see "Team was successfully updated."

  Scenario: Add project
    Given I have a team
    And I have a project named "kanban-roots"
    And I have a project named "sgtran"
    And I am on the team page
    When I follow "Manage projects"
    When I select "kanban-roots" from "Projects"
    And I select "sgtran" from "Projects"
    And I press "Save"
    Then I should see "kanban-roots and sgtran"
    And I should see "Team was successfully updated."

