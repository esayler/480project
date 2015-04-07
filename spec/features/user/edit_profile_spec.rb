# Feature: Edit profile
#   As a user
#   I want to edit my profile
#   So I can update my personal info
feature 'Edit profile', :devise do

  #before do
    #request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    #request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
  #end
  # Scenario: User can sign in with valid account
  #   Given I have a valid account
  #   And I am not signed in
  #   When I sign in
  #   Then I see the button to edit my account
  scenario "user can see 'Edit account' when signed in" do
    login
    expect(page).to have_content("Edit account")
  end

  scenario "user cannot see 'Edit account' when signed out" do
    visit root_path
    expect(page).to_not have_content("Edit account")
  end

  # Scenario: User can edit personal info when signed in
  #   Given I am signed in
  #   When I sign in
  #   Then I see an authentication error message
  scenario 'user can visit an edit page when logged in' do
    login
    expect(page).to have_content('Edit account')
    click_on 'Edit account'
    expect(page).to have_content('Edit User')
    expect(page).to have_css("button,right")
  end

  # Scenario: User can update personal info when signed in
  #   Given I am signed in
  #   So that I can update my personal info
  #   I want my new info to be persisted in the db when I press update on the edit user page
  scenario "user's new user info is saved by the db when update is pressed" do
    login
    # expect(page).to have_content('Edit account')
    click_on 'Edit account'
    # expect(page).to have_content('Edit User')
    # expect(page).to have_button("Update User")
    click_on "Update"
    expect(page).to have_content("Your account has been updated successfully.")
  end

end
