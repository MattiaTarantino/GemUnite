Feature: Requesting Participation in a Project

  Scenario: A registered user sends a participation request to a project
    Given I am a registered user
    And i am logged in
    And there exists a project
    When I click the "Invia richiesta" button on the project request page
    Then I should see a confirmation message