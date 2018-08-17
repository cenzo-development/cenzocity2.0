

Feature: Authentication

  In order to use the application
  As a user
  I should be able to log in, verify my passcode and log out


  Scenario: User Logs In
    Given I am a registered user
    And I visit the homepage
    When I fill in the login form
    Then I should be logged in
    And I should be redirected to the passcodepage

  Scenario: Verifying passcode
     Given I am a registered user
     Given I am logged in
     When I fill in the passcode form
    Then I should be redirected to the homepage
