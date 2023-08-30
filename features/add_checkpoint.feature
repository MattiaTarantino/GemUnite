Feature: Adding a checkpoint

  Scenario: User adds a checkpoint through a button
    Given the user is logged in
    And the user is on the project page
    And the user is the leader of the project
    When the user clicks on the "Aggiungi Checkpoint" button
    And fills in the checkpoint details
    And submits the form
    Then the user should see a success message
    And the user should be redirected to the checkpoint page
