Feature: Manage projects
  In order to [goal]
  [stakeholder]
  wants [behaviour]

  Scenario: Register new project
    Given I am on the new project page
    When I fill in "Nome" with "name 1"
    And I fill in "Descrição" with "description 1"
    And I fill in "Início" with "2010-01-01"
    And I fill in "Fim" with "2010-02-02"
    And I press "Criar"
    Then I should see "name 1"
    And I should see "description 1"
    And I should see "2010-01-01"
    And I should see "2010-02-02"

  Scenario: Edit a project
    Given I have a project
    When I am on the project edit page
    And I fill in "Nome" with "Some name"
    And I fill in "Descrição" with "Any description"
    And I fill in "Início" with "2010-01-01"
    And I fill in "Fim" with "2010-02-02"
    And I press "Atualizar"
    Then I should see "Some name"
    And I should see "Any description"
    And I should see "2010-01-01"
    And I should see "2010-02-02"


  Scenario: Delete project
    Given the following projects:
      | name   | description   | start      | end        |
      | name 1 | description 1 | 2010-01-01 | 2010-02-02 |
      | name 2 | description 2 | 2010-02-01 | 2010-03-02 |
      | name 3 | description 3 | 2010-03-01 | 2010-04-02 |
      | name 4 | description 4 | 2010-04-01 | 2010-05-02 |
    And I am on the projects page
    When I delete the 3rd project
    Then I should see the following projects:
      | Nome   | Descrição   | Início      | Fim        |
      | name 1 | description 1 | 2010-01-01 | 2010-02-02 |
      | name 2 | description 2 | 2010-02-01 | 2010-03-02 |
      | name 4 | description 4 | 2010-04-01 | 2010-05-02 |

