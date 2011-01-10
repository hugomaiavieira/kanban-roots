Feature: Manipulate comments in tasks
  As a user
  I want manipulate comments in tasks
  In order to help other sponsors in their job

  Scenario: Create a comment in a task
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    When I am on the task page
    And I follow "Add comment"
    And I fill in "Content" with "Some content here"
    And I press "Save"
    Then I should see "Some content here"
    And I should be on the task page
    And the comment should belongs to the task
    And I am the coment's author

