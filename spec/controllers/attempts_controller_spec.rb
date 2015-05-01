describe AttemptsController do

  before :each do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    @prof = create(:user, id: 1, role: 2)#might be 1 for prof, i forget. 2 is alum o/w
    @student = create(:user, id: 2, role: 0)
    @problem1 = create(:problem, id: 1, user_id: @prof.id)
    @attempt1 = create(:attempt, problem_id: @problem1.id, user_id: @student.id)
    allow(controller).to receive(:current_user){ @student }#edit and update are for profs only
  end

  describe "GET #index" do
    #user
    before :each do
      @problem2 = create(:problem, id: 2, user_id: @prof.id)
      @attempt2 = create(:attempt, problem_id: @problem1.id, user_id: @student.id)
      @attempt3 = create(:attempt, problem_id: @problem2.id, user_id: @student.id)#shouldn't show up in problem1's index
    end

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

    #it "fails to route correctly when a bad problem id is requested" do
      #get :index, problem_id: 0
      #expect(response.status).to redirect_to problems_path
    #end

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

    #it "fails to render when an invalid attempt id is requested" do
      #get :show, problem_id: @problem1.id, id: 0
      #expect(response.status).to redirect_to problem_attempts_path(@problem1.id)
    #end

  end

  describe 'GET #new' do
    #user
    it "Finds the problem, and assigns it to @problem" do
      #TODO: change problem_id
      get :new, problem_id: @problem1.id
      expect(assigns(:problem)).to eq @problem1
    end

    it "renders the :new template" do
      #TODO: change problem_id
      get :new, problem_id: @problem1.id
      expect(response).to render_template :new
    end

    #it "fails to render the :new template when a bad problem id is requested" do
      #get :new, problem_id: 0
      #expect(response).to redirect_to problems_path
    #end

  end

  describe 'GET #edit' do
    #user - author
    before :each do
      allow(controller).to receive(:current_user){ @prof }
    end

    it "assigns the requested attempt to @attempt" do
      #TODO: change problem_id
      get :edit, id: @attempt1.id, problem_id: @attempt1.problem_id
      expect(assigns(:attempt)).to eq @attempt1
    end

    it "renders the :edit template" do
      #TODO: change problem_id
      get :edit, id: @attempt1.id, problem_id: @attempt1.problem_id
      expect(response).to render_template :edit
    end

    #it "fails to render the :edit template when a bad problem id is requested" do
      #attempt = create(:attempt)
      #get :edit, id: attempt, problem_id: 0
      #expect(response).to redirect_to problems_path
    #end

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

      it "redirects to attempts#index" do
        post :create, problem_id: @problem1.id, attempt: attributes_for(:attempt)
        expect(response).to redirect_to problem_attempts_path(@problem1.id)
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
        #stub save
        a = build(:attempt)
        # allow(controller).to receive(:save).and_return(false)
        allow(Attempt).to receive(:new).and_return(a)
        expect(a).to receive(:save) {false}
        post :create,
          problem_id: @problem1.id,
          attempt: attributes_for(:invalid_attempt)
        expect(response).to render_template :new
      end

    end

  end

  describe 'PATCH #update' do
    #grade
    before :each do
      allow(controller).to receive(:current_user){ @prof }
    end

    context "with valid attributes" do

      it "locates the requested @attempt" do
        #a = attributes_for(:attempt, problem_id: 1)
        patch :update, problem_id: @attempt1.problem_id, id: @attempt1.id, attempt: @attempt1.attributes
        expect(assigns(:attempt)).to eq(@attempt1)
      end

      it "changes @attempt's attributes" do
        @attempt1.grade = 10
        patch :update, problem_id: @attempt1.problem_id, id: @attempt1.id, attempt: @attempt1.attributes
        expect(@attempt1.grade).to eq(10)
      end

      it "redirects to show the updated attempt" do
        patch :update, problem_id: @attempt1.problem_id, id: @attempt1.id, attempt: @attempt1.attributes
        expect(response).to redirect_to problem_attempt_path(@attempt1.problem_id, @attempt1.id)
      end

    end

    context "with invalid attributes" do

      it "doesn't change @attempt's grade" do
        @attempt1.grade = 11
        patch :update, problem_id: @attempt1.problem_id, id: @attempt1.id, attempt: @attempt1.attributes        
        expect(@attempt1.grade).to eq(-1)
      end

      it "redirects to the grading page for the ungraded attempt" do
        allow(Attempt).to receive(:update).and_return(false)
        @attempt1.grade = 11
        patch :update, problem_id: @attempt1.problem_id, id: @attempt1.id, attempt: @attempt1.attributes        
        expect(response).to redirect_to edit_problem_attempt_path(@attempt1.problem_id, @attempt1.id)
      end

    end

  end

  describe 'DELETE #destroy' do#, skip: "feature not implemented yet" do
    # admin
    before :each do
      @student = create(:user, id: 3, role: 3)
      allow(controller).to receive(:current_user){ @admin }
      # @attempt5 = create(:attempt)
    end

    it 'deletes the attempt' do
      expect{
        delete :destroy, problem_id: @attempt1.problem_id, id: @attempt1.id
      }.to change(Attempt, :count).by(-1)
    end

    it "redirects to attempts#index" do
      delete :destroy, problem_id: @attempt1.problem_id, id: @attempt1.id
      expect(response).to redirect_to problem_attempts_path(@attempt1.problem_id)
    end

  end
end
