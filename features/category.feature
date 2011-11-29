Feature: Manipulate categories
  As a user
  I want manipulate categories
  In order to organize them

  Scenario: Register a category successfully
    Given I am a contributor of "sgtran" project
    And I am authenticated
    And I am on the "sgtran" categories page
    When I follow "New Category"
    And I fill in "Name" with "Feature"
    And I fill in "Color" with "ffa5a5"
    And I press "Save"
    Then I should see "Category was successfully created."
    And I should see "Feature"
    And I should see "ffa5a5"
    And "sgtran" project should have "1" category

  Scenario Outline: Try to register categories with errors
    Given I am a contributor of "sgtran" project
    And I am authenticated
    And I am on the "sgtran" categories page
    And I have a category with name "Bug" and color "ffa5a5"
    When I follow "New Category"
    And I fill in "Name" with "<name>"
    And I fill in "Color" with "<color>"
    And I press "Save"
    Then I should see "<sentence>"
    And "sgtran" project should have "1" category

    Examples:
    | name    | color  | sentence                   |
    |         | a5d2ff | can't be blank             |
    | Feature |        | can't be blank             |
    | Feature | ffa5a5 | should be uniq for project |
    | Bug     | a5d2ff | should be uniq for project |
    | Bug     | red    | is invalid                 |
    | Bug 1   | a5d2ff | is invalid                 |

  Scenario: Edit a category
    Given I am a contributor of "sgtran" project
    And I am authenticated
    And I have a category with name "Feature" and color "ffa5a5"
    When I am on the category edit page
    And I fill in "Name" with "New feature"
    And I press "Save"
    Then I should see "New feature"
    And I should see "Category was successfully updated."

  @javascript
  Scenario: Destroy category
    Given I am a contributor of "sgtran" project
    And I am authenticated
    And I have a category with name "Feature" and color "ffa5a5"
    When I am on the "sgtran" categories page
    And I follow "Destroy" and press ok at the pop-up
    And "sgtran" project should have "0" categories

