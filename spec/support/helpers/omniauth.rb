module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        'provider' => 'google_oauth2',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'email' => 'mockemail@fake.com'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      })
    end
  end

  module SessionHelpers
    def login
      visit root_path
      expect(page).to have_content("Log in")
      auth_mock
      click_link "Log in"
    end
  end

end
