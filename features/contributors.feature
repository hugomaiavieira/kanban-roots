Feature: Manipulate contributors
  As a user
  I want manipulate contributors
  In order to organize them

  Scenario: Register contributors successfully
    Given I am on the new contributor page
    When I fill in "Name" with "Someone of Nothing"
    And I fill in "Username" with "someone"
    And I fill in "E-mail" with "someone@gmail.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully."

  Scenario Outline: Try to register contributors with errors
    Given I am on the new contributor page
    When I fill in "Name" with "<name>"
    And I fill in "Username" with "<username>"
    And I fill in "E-mail" with "<e-mail>"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "<sentence>"

    Examples:
    | name    | username | e-mail            | sentence       |
    |         | someone  | someone@gmail.com | can't be blank |
    | Someone |          | someone@gmail.com | can't be blank |
    | Someone | someone  |                   | can't be blank |
    | Someone | someone  | someone@nothing   | is invalid     |

  Scenario: Edit a contributor
    Given I am contributor with password "123456" and email "test@test.com"
    And I am authenticated
    And I am on my details page
    When I follow "Edit"
    And I fill in "Name" with "Someone of Something"
    And I fill in "Current password" with "123456"
    And I press "Update"
    Then I should see "Someone of Something"

  Scenario: Sign in with username successfully
    Given I am contributor with password "123456" and username "someone"
    Given I am on the sign in page
    When I fill in "Login" with "someone"
    And I fill in "Password" with "123456"
    And I press "Sign in"
    Then I should see "Signed in successfully."

  Scenario: Sign in with email successfully
    Given I am contributor with password "123456" and email "someone@example.com"
    Given I am on the sign in page
    When I fill in "Login" with "someone@example.com"
    And I fill in "Password" with "123456"
    And I press "Sign in"
    Then I should see "Signed in successfully."

