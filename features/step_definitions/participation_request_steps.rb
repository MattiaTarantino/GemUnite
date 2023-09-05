Given("there exists a project") do
  # Implement code to create a project or use an existing project
  @project = Project.create(info_leader: "Leader info", dimensione: 5, descrizione: "Project description", stato: "aperto", name: "Project Name")
end

When("I click the {string} button on the project request page") do |button_text|
  # Implement code to simulate clicking the button and sending the request
  visit new_user_project_request_path(user_id: @user.id, project_id: @project.id)

  fill_in 'Note', with: 'Vorrei partecipare a questo progetto'

  click_button button_text
end

Then("I should see a confirmation message") do
  # Implement code to check for the confirmation message
  expect(page).to have_content('Richiesta effettuata')
end
