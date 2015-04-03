# Feature: Log in
#   As a user
#   I want to log in
   #So I can visit protected areas of the site
feature 'Log in', :omniauth do

  #before do
    #request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    #request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
  #end
  # Scenario: User can log in with valid account
  #   Given I have a valid account
  #   And I am not signed in
  #   When I log in
  #   Then I see a success message
  scenario "user can log in with valid account" do
    login
    expect(page).to have_content("Log out")
  end

  # Scenario: User cannot log in with invalid account
  #   Given I have no account
  #   And I am not signed in
  #   When I log in
  #   Then I see an authentication error message
  scenario 'user cannot log in with invalid account' do
    # set provider's mock to a symbol instead of a hash --> will fail
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    visit root_path
    expect(page).to have_content("Log in")
    click_link "Log in"
    expect(page).to have_content('Invalid credentials')
  end

end
