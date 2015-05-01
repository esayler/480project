describe ProblemsController do

  before :each do

    #let (:user) { FactoryGirl.create :user, :student }

    @prof = create(:user, id: 1, role: 2)
    # @attempt1 = create(:attempt, problem_id: 1)
    # @attempt2 = create(:attempt, problem_id: 1)
    @problem1 = create(:problem, id: 1, user_id: @prof.id)
    @problem2 = create(:problem, id: 2, user_id: @prof.id)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user){ @prof }
  end

  describe "GET #index" do
    #student
    before :each do
      @student = create(:user, id: 2, role: 0)
      allow(controller).to receive(:current_user){ @student }
    end

    it "routes correctly" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template to show all problems" do
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:problems)).to match_array([@problem1, @problem2])
    end
  end

  describe "GET #show" do
    it "routes correctly" do
      get :show, id: @problem1
      #expect(Problem).to receive(:find).with("1") { @problem1 }
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      get :show, id: @problem1
      #expect(Problem).to receive(:find).with("1") { @problem1 }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    #non-student
    it "assigns a new problem to @problem" do
      #TODO: change problem_id
      get :new
      expect(assigns(:problem)).to be_a_new(Problem)
    end

    it "renders the :new template" do
      #TODO: change problem_id
      get :new
      expect(response).to render_template :new
    end

  end

  describe "POST #create" do

    context "with valid attributes" do

      it "saves the new problem to the database" do
        expect{
          post :create, problem: attributes_for(:problem)
        }.to change(Problem, :count).by(1)
      end

      it "should redirect to index on sucess" do
        #post :create, attempt: attributes_for(:attempt)
        post :create, problem: attributes_for(:problem)
        expect(response).to redirect_to problems_path
      end

    end

    context "with invalid attributes" do

      it "does not save the new problem in the database" do
        expect{
          post :create, problem: attributes_for(:invalid_attempt)
        }.not_to change(Problem, :count)
      end

      it "re-renders the :new template" do
        post :create, problem: attributes_for(:invalid_problem)
        expect(response).to redirect_to new_problem_path
      end

    end

  end

  describe 'GET #edit' do
    #user - creator
    #TODO: clean up
    it "assigns the requested problem to @problem" do
      problem = create(:problem)
      get :edit, id: problem
      expect(assigns(:problem)).to eq problem
    end

    it "renders the :edit template" do
      problem = create(:problem)
      get :edit, id: problem
      expect(response).to render_template :edit
    end

  end
end
