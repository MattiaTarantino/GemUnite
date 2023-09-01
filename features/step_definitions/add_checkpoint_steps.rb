# Import necessary libraries and set up your testing environment as needed.

Given("I am registered as user") do
  @user = User.create(id: 12, username: "testuser", email: "test@user.com", password: "Ciao1234!")
end

Given("I am the leader of a started project") do
  @project = Project.create(name: "testproject", dimensione: 3, info_leader: "test info", stato: "iniziato", descrizione: "testdescription")
  @chat = Chat.create(project_id: @project.id)
  user_project = UserProject.create(user_id: @user.id, project_id: @project.id, role: "leader")
end

Given("I am logged in") do
  visit new_user_session_path
  fill_in 'Email', with: 'test@user.com'
  fill_in 'Password', with: 'Ciao1234!'
  click_button 'Accedi'

  expect(page).to have_content('Signed in successfully')
end

Given("I am on the project page") do
  visit user_project_show_my_project_path(user_id: @user.id, project_id: @project.id)
end


When("I click the {string} button") do |button_text|
  click_link button_text
end

When("I fill in the checkpoint details") do
  fill_in 'Nome', with: 'testcheckpoint'
  fill_in 'Descrizione', with: 'chekpoint testdescription'
end

When("I submit the form") do
  click_button "Create Checkpoint"
end

Then("I should see a success message") do
  expect(page).to have_content('Checkpoint creato con successo.')
end

Then("I should be redirected to the checkpoint page") do
  # Capture the ID of the newly created checkpoint from the URL
  checkpoint_id = current_url.split('/').last

  # Construct the expected path using the captured checkpoint ID
  expected_path = user_project_checkpoint_path(user_id: @user.id, project_id: @project.id, id: checkpoint_id)

  expect(page).to have_current_path(expected_path)
end

