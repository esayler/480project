require 'rails_helper'

RSpec.describe AttemptsController, :type => :controller do
  before :each do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    @user = create(:user, id: 1)
    @attempt1 = create(:attempt, problem_id: 1)
    @attempt2 = create(:attempt, problem_id: 1)
    @problem = create(:problem, id: 1)
    #user = double('user')
    #user.stub(:id).and_return(1)
    allow(controller).to receive(:current_user){ @user }

  end
  describe "GET #index" do
    #add context for problem_id and no problem_id
    it "routes correctly" do
      get :index, problem_id: @problem.id
      expect(response.status).to eq(200)
    end
    it "populates an array of all attempts regardless of problem_id" do
      get :index, problem_id: @problem.id
      expect(assigns(:attempts)).to match_array([@attempt1, @attempt2])
    end
    it "renders the :index template" do
      #x, y = create(:attempt), create(:attempt)
      #expect(Attempt).to receive(:all) { [x,y] }
      get :index, problem_id: @problem.id
      expect(response).to render_template :index
      #expect(assigns(:attempts)).to match_array([x,y])
    end
  end


  describe "GET #show" do
    it "assigns the requested attempt to @attempt" do
      #get :index, problem_id: @problem.id
      get :show, problem_id: @problem.id, id: @attempt1.id
      expect(assigns(:attempt)).to eq @attempt1
    end

    it "renders the :show template" do
      get :show, problem_id: @problem.id, id: @attempt1.id
      expect(response).to render_template :show
    end

    it "routes correctly" do
      get :show, problem_id: @problem.id, id: @attempt1.id
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    it "should redirect to index on success" do
      post :create, problem_id: @problem.id, attempt: attributes_for(:attempt)

      context "with valid attributes" do
        it "saves the new attempt to the database" do
          expect{
            post :create,
              problem_id: @problem.id,
              attempt: attributes_for(:attempt)
          }.to change(Attempt, :count).by(1)
        end

        it "redirects to attempts#show" do
          post :create,
            problem_id: @problem.id,
            attempt: attributes_for(:attempt)
          expect(response).to redirect_to attempt_path(assigns[:attempt])
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
        end
      end
    end


    #it "should redirect back to new template on failure and flash a warning" do
      ##a = Attempt.new
      ##Attempt.should_receive(:new).and_return(a)
      #a.should_receive(:save).and_return(true)
      #post :create, { :attempt => { "user_id"=>-1, "problem_id"=>-1, "submission" => "my best guess" } }
      #response.should redirect_to(problems_path)#TODO
      #expect(response).to have_content("Attempt failed to be submitted")
    #end
  end
end
