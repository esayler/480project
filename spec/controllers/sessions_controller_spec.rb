describe SessionsController, :omniauth do

  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe "#create" do

    it "creates a session" do
      expect(session[:user_id]).to be_nil
      u = User.new
      u.id = 1
      User.should_receive(:find_by).and_return(u)
      post :create, provider: :google_oauth2
      expect(session[:user_id]).not_to be_nil
    end

    it "redirects to the home page for registered user" do
      u = User.new
      User.should_receive(:find_by).and_return(u)
      post :create, provider: :google_oauth2
      expect(response).to redirect_to root_url
    end

    it "redirects to new user page for unregistered user" do
      User.should_receive(:find_by).and_return(nil)
      post :create, provider: :google_oauth2
      expect(response).to redirect_to new_user_path
    end
  end

  describe "#destroy" do

    before do
      u = User.new
      u.id = 1
      User.should_receive(:find_by).and_return(u)
      post :create, provider: :google_oauth2
    end

    it "resets the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end

  end

end
