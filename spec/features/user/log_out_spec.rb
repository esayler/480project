# Feature: Log out
#   As a user
#   I want to log out
#   So I can protect my account from unauthorized access
feature 'Log out', :omniauth do

  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I log out
  #   Then I see a signed out message
  scenario 'user logs out successfully' do
    login
    click_link 'Log out'
    expect(page).to have_content 'Signed out'
  end

end
