# Feature: Edit profile
#   As a user
#   I want to edit my profile
#   So I can update my personal info
feature 'Edit profile', :devise do
  # Scenario: User can log in with valid account
  #   Given I have a valid account
  #   And I am not logged in
  #   When I log in
  #   Then I see the button to edit my account
  scenario "user can see 'Edit My Profile' when logged in" do
    login
    expect(page).to have_content("Edit My Profile")
  end

  scenario "user cannot see 'Edit My Profile' when logged out" do
    visit root_path
    expect(page).to_not have_content("Edit My Profile")
  end

  # Scenario: User can edit personal info when logged in
  #   Given I have a valid account
  #   When I log in
  #   Then I see an authentication error message
  scenario 'user can visit an edit page when logged in' do
    login
    expect(page).to have_content('Edit My Profile')
    click_on 'Edit My Profile'
    expect(page).to have_content('Edit User')
    expect(page).to have_css('button,right')
  end

  # Scenario: User can update personal info when logged in
  #   Given I am logged in
  #   So that I can update my personal info
  #   I want my new info to be persisted in the db when I press update on the edit user page
  scenario "user can successfully update user profile with valid attributes" do
    login
    expect(page).to have_content('Edit My Profile')
    click_on 'Edit My Profile'
    expect(page).to have_content('Edit User')
    expect(page).to have_button('Update')
    fill_in 'Name', :with => Faker::Name.name
    fill_in 'Email', :with => Faker::Internet.safe_email
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end

end
