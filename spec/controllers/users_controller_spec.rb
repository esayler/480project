describe UsersController do

  before :each do

    #let (:user) { FactoryGirl.create :user, :student }

    @user = create(:user, id: 1, role: 2)
    # @attempt1 = create(:attempt, problem_id: 1)
    # @attempt2 = create(:attempt, problem_id: 1)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user){ @user }
  end

  describe "GET #show" do
    it "routes correctly" do
      get :show, id: @user.id
      #expect(Problem).to receive(:find).with("1") { @problem1 }
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      get :show, id: @user.id
      #expect(Problem).to receive(:find).with("1") { @problem1 }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    #user - creator
    #TODO: clean up
    it "assigns the requested user to @user" do
      get :edit, id: @user.id
      expect(assigns(:user)).to eq @user
    end

    it "renders the :edit template" do
      get :edit, id: @user.id
      expect(response).to render_template :edit
    end
  end

end
