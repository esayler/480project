# Feature: User Index
#   As a site administrator
#   I want to be able to view a list of users
#   So I can easily make changes to their accounts
feature 'User Index' do
  # Scenario: Admin can log in with valid account
  #   Given I have a valid admin account
  #   And I am not logged in
  #   When I log in
  #   Then I see a link to view a list of Users
  scenario "Admin can see link 'Users' when logged in", :skip => "admin mock not yet implemented" do
    login #TODO: as an admin
    expect(page).to have_content("Users")
  end

  scenario "guests (not logged in) can't see link 'Users'", :skip => "admin mock not yet implemented"  do
    visit root_path
    expect(page).to_not have_content("Users")
  end

  scenario "non-admin cannot see the link 'Users' when logged-in" do
    login #TODO: as an non-admin (already true)
    expect(page).to_not have_content("Users")
  end

  # Scenario: Admin can edit user account info when logged in
  #   Given I am an admin
  #   When I log in
  #   And I click 'Users'
  #   And I click on a specific username
  scenario "admin can visit the edit page for a user when logged in", :skip => "admin mock not implemented yet" do
    login #TODO: as an admin
    expect(page).to have_content('Users')
    #click_on username
    expect(page).to have_content('Edit User')
    expect(page).to have_css("button,right")
  end

  # Scenario: non-admin account cannot view a list of all users to edit roles
  #   Given I am not an admin
  #   When I log in
  #   And try to visit the user index URI
  #   I want to see an error message if I cannot do that action
  scenario "non-admin account cannot visit the user index 'Users' when logged-in" do
    login #TODO: as an non-admin (already true)
    visit users_path
    expect(page).to have_content("You are not authorized to do that!")
  end

  # Scenario: Admin can update a user's role info when logged in
  #   Given I am an admin
  #   And I have logged in
  #   So that I can update a user's defined role
  #   I want the updated role to be persisted in the db
  scenario "changes to user info is saved to the db", :skip => "need to add actual check of db persistence" do
    login #TODO: as an admin
    # expect(page).to have_content('Edit account')
    click_on 'Edit account'
    # expect(page).to have_content('Edit User')
    # expect(page).to have_button("Update User")
    click_on "Update"
    expect(page).to have_content("Your account has been updated successfully.")
  end

end
