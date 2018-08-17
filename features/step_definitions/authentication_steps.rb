

Given("I am a registered user") do
    @registered = FactoryBot.create(:user, email: 'henry@mail.com', password: 'pa$$word', pass_code: Digest::SHA512.hexdigest("222222"))
end

Given("I visit the homepage") do
  visit root_path
end

When("I fill in the login form") do
  fill_in 'email', with: @registered.email, disabled: false
  fill_in 'password', with: @registered.password, disabled: false
  click_button('Login')
end

Then("I should be logged in") do
  expect(page).to have_content("logged in sucessfully")
end

Then("I should be redirected to the passcodepage") do
  expect(current_path). to eq passcode_path
end

Given("I am logged in") do
  visit root_path

  fill_in 'email', with: @registered.email, disabled: false
  fill_in 'password', with: @registered.password, disabled: false
  click_button('Login')

end

When("I fill in the passcode form") do
  fill_in 'smscode', with: '222222'
  click_button('Continue')
end

Then("I should be redirected to the homepage") do
  expect(current_path).to eq root_path
end
