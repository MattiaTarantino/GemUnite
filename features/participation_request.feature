Feature: Requesting Participation in a Project

  Background: A user is registered
    Given I am a registered user
    And I am logged in
  Scenario: A registered user sends a participation request to a project
    Given there exists a project
    When I click the "Invia richiesta" button on the project request page
    Then I should see a confirmation message