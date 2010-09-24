Feature: Manage contributors
  As a user
  I want manage contributors
  In order to organize them

  Scenario: Register contributors successfully
    Given I am on the new contributor page
    When I fill in "Name" with "Someone of Nothing"
    And I fill in "E-mail" with "someone@gmail.com"
    And I press "Save"
    Then I should see "Someone of Nothing"
    And I should see "someone@gmail.com"

  Scenario Outline: Try to register contributors with errors
    Given I am on the new contributor page
    When I fill in "Name" with "<name>"
    And I fill in "E-mail" with "<e-mail>"
    And I press "Save"
    Then I should see "<sentence>"

    Examples:
    | name               | e-mail            | sentence       |
    |                    | someone@gmail.com | can't be blank |
    | Someone of Nothing |                   | can't be blank |
    | Someone of Nothing | someone@nothing   | is invalid     |

  Scenario: Edit a contributor
    Given I have a contributor
    When I am on the contributor edit page
    And I fill in "Name" with "Someone of Something"
    And I press "Save"
    Then I should see "Someone of Something"

