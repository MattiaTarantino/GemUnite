Given("I am a registered user") do
  @user = User.create(id: 20, username: "testuser", email: "test@user.com", password: "Ciao1234!")
end

Given("I am logged in") do
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'

  expect(page).to have_content('Signed in successfully')
end

When("I click the {string} button") do |button_text|
  click_link button_text
end