
Given("the user is logged in") do
  user = FactoryBot.create(:user)

  sign_in user
end

And("the user is on the project page") do
  # Implement code to visit the project page
end

And("the user is the leader of the project") do
  # Implement code to verify user's leadership status
end

When("the user clicks on the {string} button") do |button_text|
  # Implement code to simulate clicking the button
end

And("fills in the checkpoint details") do
  # Implement code to fill in checkpoint details in the form
end

And("submits the form") do
  # Implement code to submit the form
end

Then("the user should see a success message") do
  # Implement code to check for the success message on the page
end

And("the user should be redirected to the checkpoint page") do
  # Implement code to check for the correct redirection
end
