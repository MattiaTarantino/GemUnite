Given("there exists a project") do
  # Implement code to create a project or use an existing project
  @project = Project.create(info_leader: "Leader info", dimensione: 5, descrizione: "Project description", stato: "aperto", name: "Project Name")
end

Given("i have already sent the request that hasn't been already accepted or rejected") do
  # Implement code to create a project or use an existing project
  @request = Request.create(note: "Vorrei partecipare a questo progetto", stato_accettazione: "In attesa", user_id: @user.id, project_id: @project.id)
end

Given("I am on the project information page") do
  # Implement code to create a project or use an existing project
  visit user_project_path(@user, @project)
end

Given("I am on the project request page") do
  # Implement code to create a project or use an existing project
  visit new_user_project_request_path(@user, @project)
end

Given("I fill the request details") do
  # Implement code to create a project or use an existing project
  fill_in 'Note', with: 'Vorrei partecipare a questo progetto'
end

When("I send the request") do
  # Implement code to create a project or use an existing project
  click_button "Invia richiesta"
end

Then("I should see a confirmation message") do
  # Implement code to check for the confirmation message
  expect(page).to have_content('Richiesta effettuata')
end

Then("I should see a information message") do
  # Implement code to check for the confirmation message
  expect(page).to have_content('Hai già richiesto di partecipare a questo progetto')
end