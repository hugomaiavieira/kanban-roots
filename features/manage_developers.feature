Feature: Manage developers
  As a [stakeholder]
  I want [behaviour]
  In order to [goal]

  Scenario: Register developers successfully
    Given I am on the new developer page
    When I fill in "Name" with "Someone of Nothing"
    And I fill in "E-mail" with "someone@gmail.com"
    And I press "Create"
    Then I should see "Someone of Nothing"
    And I should see "someone@gmail.com"

  Scenario Outline: Try to register developers with errors
    Given I am on the new developer page
    When I fill in "Name" with "<name>"
    And I fill in "E-mail" with "<e-mail>"
    And I press "Create"
    Then I should see "<sentence>"

    Examples:
    | name               | e-mail            | sentence       |
    |                    | someone@gmail.com | can't be blank |
    | Someone of Nothing |                   | can't be blank |
    | Someone of Nothing | someone@nothing   | is invalid     |

  Scenario: Edit a developer
    Given I have a developer
    When I am on the developer edit page
    And I fill in "Name" with "Someone of Something"
    And I press "Update"
    Then I should see "Someone of Something"

