describe ProblemsController do

  before :each do
    @prof = create(:user, id: 1, role: 2)
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
        post :create, problem: attributes_for(:problem)
        expect(response).to redirect_to problems_path
      end

    end

    context "with invalid attributes" do

      before :each do
        # p = build(:problem, id: 3, user_id: @prof.id)
        allow(Problem).to receive(:create).and_return(false)
        # allow(p).to receive(:save).and_return(false)
      end

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
      get :edit, id: @problem1.id
      expect(assigns(:problem)).to eq @problem1
    end

    it "renders the :edit template" do
      get :edit, id: @problem1.id
      expect(response).to render_template :edit
    end

  end

  describe 'PATCH #update' do
    #update

    context "with valid attributes" do

      it "locates the requested problem" do
        @problem1.name = @problem1.name.reverse
        patch :update, id: @problem1.id, problem: @problem1.attributes
        expect(assigns(:problem)).to eq(@problem1)
      end

      it "changes @problem's attributes" do
        @problem1.description = @problem1.description.reverse
        # @problem1.difficulty = (@problem1.difficulty) % 5 + 1
        patch :update, id: @problem1.id, problem: @problem1.attributes
        p = @problem1.reload
        expect(p).to eq(@problem1)
      end

      it "redirects to show the updated attempt" do
        @problem1.time_limit = @problem1.time_limit * 2
        patch :update, id: @problem1.id, problem: @problem1.attributes
        expect(response).to redirect_to problem_path(@problem1.id)
      end

    end

    context "with invalid attributes" do

      it "doesn't change @problem's difficulty if out of range" do
        @problem1.difficulty = 7.5
        patch :update, id: @problem1.id, problem: @problem1.attributes        
        @problem1.reload
        expect(@problem1.difficulty).not_to eq(7.5)
      end

      it "doesn't change @problem's time limit if negative" do
        @problem1.time_limit = -1
        patch :update, id: @problem1.id, problem: @problem1.attributes        
        @problem1.reload
        expect(@problem1.time_limit).not_to eq(-1)
      end

      it "redirects to the edit page" do
        allow(@problem1).to receive(:update_attributes).and_return(false)
        patch :update, id: @problem1.id, problem: @problem1.attributes      
        expect(response).to redirect_to edit_problem_attempt_path(@problem1.id)
      end

    end

  end

  describe 'DELETE #destroy' do#, skip: "feature not implemented yet" do
    # admin
    before :each do
      @admin = create(:user, id: 3, role: 3)
      allow(controller).to receive(:current_user){ @admin }
    end

    it 'deletes the problem' do
      expect{
        delete :destroy, id: @problem1.id
      }.to change(Problem, :count).by(-1)
    end

    it "redirects to problems#index" do
      delete :destroy, id: @problem1.id
      expect(response).to redirect_to problems_path
    end

  end
end
