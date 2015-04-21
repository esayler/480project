describe AttemptsController do

  before :each do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    @user = create(:user, id: 1)
    @attempt1 = create(:attempt, problem_id: 1)
    @attempt2 = create(:attempt, problem_id: 1)
    @problem = create(:problem, id: 1)
    allow(controller).to receive(:current_user){ @user }
  end

  describe "GET #index" do
    #user
    it "routes correctly" do
      get :index, problem_id: @problem.id
      expect(response.status).to eq(200)
    end

    it "populates an array of all attempts regardless of problem_id" do
      get :index, problem_id: @problem.id
      expect(assigns(:attempts)).to match_array([@attempt1, @attempt2])
    end

    it "renders the :index template" do
      get :index, problem_id: @problem.id
      expect(response).to render_template :index
    end

  end

  describe "GET #show" do
    #user
    it "assigns the requested attempt to @attempt" do
      #get :index, problem_id: @problem.id
      get :show, problem_id: @problem.id, id: @attempt1.id
      expect(assigns(:attempt)).to eq @attempt1
    end

    it "renders the :show template" do
      #problem = create(:problem)
      #attempt = create(:attempt, problem: problem)
      #get :show, id: attempt, problem_id: problem.id
      get :show, problem_id: @problem.id, id: @attempt1.id
      expect(response).to render_template :show
    end

    it "routes correctly" do
      get :show, problem_id: @problem.id, id: @attempt1.id
      expect(response.status).to eq(200)
    end

  end

  describe 'GET #new' do
    #user
    it "assigns a new Attempt to @attempt" do
      #TODO: change problem_id
      get :new, problem_id: 1
      expect(assigns(:attempt)).to be_a_new(Attempt)
    end

    it "renders the :new template" do
      #TODO: change problem_id
      get :new, problem_id: 1
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do
    #user - author
    it "assigns the requested attempt to @attempt" do
      attempt = create(:attempt)
      #TODO: change problem_id
      get :edit, id: attempt, problem_id: 1
      expect(assigns(:attempt)).to eq attempt
    end

    it "renders the :edit template" do
      attempt = create(:attempt)
      #TODO: change problem_id
      get :edit, id: attempt, problem_id: 1
      expect(response).to render_template :edit
    end

  end

  describe "POST #create" do
    #user
    context "with valid attributes" do

      it "saves the new attempt to the database" do
        expect{
          post :create,
          problem_id: @problem.id,
          attempt: attributes_for(:attempt)
        }.to change(Attempt, :count).by(1)
      end

      it "redirects to attempts#show" do
        post :create, problem_id: @problem.id, attempt: attributes_for(:attempt)
        expect(response).to redirect_to problem_attempts_path(assigns[:problem])
        #expect(response).to have_content("Attempt successfully submitted")
      end

    end

    context "with invalid attributes" do

      it "does not save the new attempt in the database" do
        expect{
          post :create,
          problem_id: @problem.id,
          attempt: attributes_for(:invalid_attempt)
        }.not_to change(Attempt, :count)
      end

      it "re-renders the :new template" do
        post :create,
          problem_id: @problem.id,
          attempt: attributes_for(:invalid_attempt)
        expect(response).to render_template :new
        #expect(response).to have_content("Attempt failed to be submitted")
      end

    end

  end

  describe 'PATCH #update' do
    #grade
    before :each do
      @attempt3 = create(:attempt)
      create(:problem, id: 1)
    end

    context "with valid attributes" do

      it "locates the requested @attempt" do
        patch :update, id: @attempt3, attempt: attributes_for(:attempt)
        expect(assigns(:attempt)).to eq(@attempt3)
      end

      it "changes @attempt's attributes" do
        patch :update, problem_id: 1, id: @attempt3,
          attempt: attributes_for(:attempt, grade: 10)
        @attempt3.reload
        expect(@attempt3.grade).to eq(10)
      end

      it "redirects to the updated attempt" do
        patch :update, id: @attempt3, attempt: attributes_for(:attempt)
        expect(response).to redirect_to @attempt3
      end

    end

    context "with invalid attributes" do
      skip
    end

  end

  describe 'DELETE #destroy', skip: "feature not implemented yet" do
    # admin
    before :each do
      @attempt4 = create(:attempt)
    end

    it 'deletes the attempt' do
      expect{
        delete :destroy, id: @attempt4
      }.to change(Attempt, :count).by(-1)
    end

    it "redirects to attempts#index" do
      delete :destroy, id: @attempt4
      expect(response).to redirect_to attempts_path
    end

  end
end
