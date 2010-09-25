Feature: Manage project's contributors
  As a project's manager
  I want manage contributors
  In order allow (or not) them to manipulate tasks of the project

  Scenario:
    Given I have a project
    And I have a contributor named "Hugo Maia Vieira"
    And I have a contributor named "Rodrigo Manhães"
    And I am on the project edit page
    When I follow "Manage contributors"
    Then I should be on the manage contributors page
    When I select "Hugo Maia Vieira" from "Contributors"
    When I select "Rodrigo Manhães" from "Contributors"
    And I press "Save"
    Then I should see "Hugo Maia Vieira and Rodrigo Manhães"

