describe AttemptsController do

  before :each do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    @user = create(:user, id: 1)
    @problem1 = create(:problem, id: 1)
    @problem2 = create(:problem, id: 2)
    @attempt1 = create(:attempt, problem_id: 1)
    @attempt2 = create(:attempt, problem_id: 1)
    @attempt3 = create(:attempt, problem_id: 2)
    allow(controller).to receive(:current_user){ @user }
  end

  describe "GET #index" do
    #user
    it "routes correctly" do
      get :index, problem_id: @problem1.id
      expect(response.status).to eq(200)
    end

    it "populates an array of all attempts regardless of problem_id" do
      get :index, problem_id: @problem1.id
      expect(assigns(:attempts)).to match_array([@attempt1, @attempt2])
    end

    it "renders the :index template" do
      get :index, problem_id: @problem1.id
      expect(response).to render_template :index
    end

    it "fails to route correctly when a bad problem id is requested" do
      get :index, problem_id: 0
      expect(response.status).to redirect_to problems_path
    end

  end

  describe "GET #show" do
    #user
    it "assigns the requested attempt to @attempt" do
      #get :index, problem_id: @problem1.id
      get :show, problem_id: @problem1.id, id: @attempt1.id
      expect(assigns(:attempt)).to eq @attempt1
    end

    it "renders the :show template" do
      #problem = create(:problem)
      #attempt = create(:attempt, problem: problem)
      #get :show, id: attempt, problem_id: problem.id
      get :show, problem_id: @problem1.id, id: @attempt1.id
      expect(response).to render_template :show
    end

    it "routes correctly" do
      get :show, problem_id: @problem1.id, id: @attempt1.id
      expect(response.status).to eq(200)
    end

    it "fails to render when an invalid attempt id is requested" do
      get :show, problem_id: @problem1.id, id: 0
      expect(response.status).to redirect_to problem_attempts_path(@problem1.id)
    end

  end

  describe 'GET #new' do
    #user
    it "assigns a new Attempt to @attempt" do
      #TODO: change problem_id
      get :new, problem_id: @problem1.id
      expect(assigns(:attempt)).to be_a_new(Attempt)
    end

    it "renders the :new template" do
      #TODO: change problem_id
      get :new, problem_id: @problem1.id
      expect(response).to render_template :new
    end

    it "fails to render the :new template when a bad problem id is requested" do
      get :new, problem_id: 0
      expect(response).to redirect_to problems_path
    end

  end

  describe 'GET #edit' do
    #user - author
    it "assigns the requested attempt to @attempt" do
      attempt = create(:attempt)
      #TODO: change problem_id
      get :edit, id: attempt, problem_id: @problem1.id
      expect(assigns(:attempt)).to eq attempt
    end

    it "renders the :edit template" do
      attempt = create(:attempt)
      #TODO: change problem_id
      get :edit, id: attempt, problem_id: @problem1.id
      expect(response).to render_template :edit
    end

    it "fails to render the :edit template when a bad problem id is requested" do
      attempt = create(:attempt)
      get :edit, id: attempt, problem_id: 0
      expect(response).to redirect_to problems_path
    end

  end

  describe "POST #create" do
    #user
    context "with valid attributes" do

      it "saves the new attempt to the database" do
        expect{
          post :create,
          problem_id: @problem1.id,
          attempt: attributes_for(:attempt)
        }.to change(Attempt, :count).by(1)
      end

      it "redirects to attempts#show" do
        post :create, problem_id: @problem1.id, attempt: attributes_for(:attempt)
        expect(response).to redirect_to problem_attempts_path(assigns[:problem])
        #expect(response).to have_content("Attempt successfully submitted")
      end

    end

    context "with invalid attributes" do

      it "does not save the new attempt in the database" do
        expect{
          post :create,
          problem_id: @problem1.id,
          attempt: attributes_for(:invalid_attempt)
        }.not_to change(Attempt, :count)
      end

      it "re-renders the :new template" do
        post :create,
          problem_id: @problem1.id,
          attempt: attributes_for(:invalid_attempt)
        expect(response).to render_template :new
        #expect(response).to have_content("Attempt failed to be submitted")
      end

    end

  end

  describe 'PATCH #update' do
    #grade
    before :each do
      @attempt4 = create(:attempt)
      create(:problem, id: 1)
    end

    context "with valid attributes" do

      it "locates the requested @attempt" do
        patch :update, id: @attempt4, attempt: attributes_for(:attempt)
        expect(assigns(:attempt)).to eq(@attempt4)
      end

      it "changes @attempt's attributes" do
        patch :update, problem_id: 1, id: @attempt4,
          attempt: attributes_for(:attempt, grade: 10)
        @attempt4.reload
        expect(@attempt4.grade).to eq(10)
      end

      it "redirects to show the updated attempt" do
        patch :update, id: @attempt4, attempt: attributes_for(:attempt)
        expect(response).to redirect_to problem_attempt_path(@attempt4.problem_id, @attempt4.id)
      end

    end

    context "with invalid attributes" do

      it "doesn't change @attempt's grade" do
        patch :update, problem_id: 1, id: @attempt4,
          attempt: attributes_for(:attempt, grade: 11)
        @attempt4.reload
        expect(@attempt4.grade).to eq(-1)
      end

      it "redirects to the grading page for the ungraded attempt" do
        patch :update, id: @attempt4, attempt: attributes_for(:attempt, grade: -1)
        expect(response).to redirect_to edit_problem_attempt_path(@attempt4.problem_id, @attempt4.id)
      end

    end

  end

  describe 'DELETE #destroy', skip: "feature not implemented yet" do
    # admin
    before :each do
      @attempt5 = create(:attempt)
    end

    it 'deletes the attempt' do
      expect{
        delete :destroy, id: @attempt5
      }.to change(Attempt, :count).by(-1)
    end

    it "redirects to attempts#index" do
      delete :destroy, id: @attempt5
      expect(response).to redirect_to problem_attempts_path(@attempt5.problem_id)
    end

  end
end
