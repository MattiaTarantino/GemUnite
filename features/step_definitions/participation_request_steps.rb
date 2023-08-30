Given("I am a registered user") do
  # Implement code to create a registered user or use a testing user
  User.create(username: "testuser", email: "test@example.com", password: "password")
end

Given("there exists a project") do
  # Implement code to create a project or use an existing project
end

When("I click the {string} button on the project page") do |button_text|
  # Implement code to simulate clicking the button and sending the request
end

When("I click the {string} button on the project page on which the request had already been sent") do |button_text|
  # Implement code to simulate clicking the button and sending the request
end

Then("I should see a confirmation message") do
  # Implement code to check for the confirmation message
end

Then("I should see an error message") do
  # Implement code to check for the error message
end
