describe UsersController do

  before :each do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    @admin = create(:user, id: 1, role: 3)
    @student = create(:user, id: 2, role: 0)
    allow(controller).to receive(:current_user){ @admin }
  end

  describe "GET #index" do
    it "routes correctly" do
      get :index
      expect(response.status).to eq(200)
    end

    it "populates an array of all users" do
      get :index
      expect(assigns(:users)).to match_array([@admin, @student])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    #user
    it "assigns the requested user to @user" do
      get :show, id: @student
      expect(assigns(:user)).to eq @student
    end

    it "renders the :show template" do
      get :show, id: 2
      expect(response).to render_template :show
    end

    it "routes correctly" do
      get :show, id: 2
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #edit' do
    it "assigns the requested user to @user" do
      get :edit, id: @student
      expect(assigns(:user)).to eq @student
    end

    it "renders the :edit template" do
      get :edit, id: @student
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context "with valid attributes" do

      it "locates the requested user" do
        patch :update, id: @student, user: attributes_for(:user)
        expect(assigns(:user)).to eq @student
      end

      it "changes @user's attributes" do
        patch :update, id: @student,
          user: attributes_for(:user,
                               name: 'Testdude',
                               email: 'example@blah.com')
        @student.reload
        expect(@student.name).to eq 'Testdude'
        expect(@student.email).to eq 'example@blah.com'
      end

      it "redirects to the users index" do
        patch :update, id: @student, user: attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid attributes", :skip => :true do
    end

  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      allow(controller).to receive(:current_user){ @student }
      expect{
        delete :destroy, id: @student
      }.to change(User, :count).by(-1)
    end

    it "redirects to users#index" do
      allow(controller).to receive(:current_user){ @student }
      delete :destroy, id: @student
      expect(response).to redirect_to users_path
    end
  end
end


