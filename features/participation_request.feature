Feature: Requesting Participation in a Project

  Scenario: A registered user sends a participation request to a project
    Given I am a registered user
    And there exists a project
    When I click the "Partecipa" button on the project page
    Then I should see a confirmation message

  Scenario: A registered user sends twice a participation request to a project
    Given I am a registered user
    When I click the "Partecipa" button on the project page on which the request had already been sent
    Then I should see an error message