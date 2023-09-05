Feature: Requesting Participation in a Project

  Background: A user is registered
    Given I am a registered user
    And I am logged in

  Scenario: A registered user sends a participation request to a project
    Given there exists a project
    And I am on the project request page
    And I fill the request details
    When I send the request
    Then I should see a confirmation message

  @common
  Scenario: A registered user sends a participation request to a project of which he has already sent the request
    Given there exists a project
    And i have already sent the request that hasn't been already accepted or rejected
    And I am on the project information page
    When I click the "Partecipa" button
    Then I should see a information message