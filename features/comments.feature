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
    Then I should be on the task page
    And I should see "Some content here"
    And the comment should belongs to the task
    And I am the coment's author

  Scenario: Edit a comment
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    And I write a comment for this task
    When I am on the task page
    And I follow "Edit" within "div.comment"
    And I fill in "Content" with "I'm editing this content"
    And I press "Save"
    Then I should be on the task page
    And I should see "I'm editing this content"

  Scenario: Edit only my comment
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    And there is a comment for this task
    When I am on the edit comment page
    Then I should be on the task page

  Scenario: See the edit link only in my comments
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    And there is a comment for this task
    When I am on the task page
    Then I should not see "Edit" within "div.comment"

  @javascript
  Scenario: Destroy a comment
    Given I am a contributor of "Sgtran" project
    And I am authenticated
    And I have a task of "Sgtran" project
    And I write a comment for this task
    When I am on the task page
    And I follow "Destroy" within "div.comment" and press ok at the pop-up
    Then I should be on the task page
    And The comment should no longer exist

