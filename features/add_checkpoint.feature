Feature: Adding a checkpoint

  Background: A user is registered
    Given I am a registered user
    And I am the leader of a started project
    And I am logged in

  @common
  Scenario: Leader adds a checkpoint through a button
    Given I am on the project page
    When I click the "Aggiungi checkpoint" button
    And I fill in the checkpoint details
    And I submit the form
    Then I should see a success message
    And I should be redirected to the checkpoint page
