require 'rails_helper'

RSpec.describe ProblemsController, :type => :controller do
  before :each do
    @user = create(:user, id: 1)
    @attempt1 = create(:attempt, problem_id: 1)
    @attempt2 = create(:attempt, problem_id: 1)
    @problem1 = create(:problem, id: 1)
    @problem2 = create(:problem, id: 2)
    #user = create(:user, id: 1)
    allow(controller).to receive(:authenticate_user!).and_return(true)
    #user = double('user')
    #user.stub(:id).and_return(1)
    allow(controller).to receive(:current_user){ @user }
  end

  describe "GET #index" do
    it "routes correctly" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template to show all problems" do
      #x, y = Problem.create!, Problem.create!
      #x, y = build(:problem), build(:problem)
      #expect(Problem).to receive(:all) { [x,y] }
      get :index
      expect(response).to render_template(:index)
      expect(assigns(:problems)).to match_array([@problem1, @problem2])
    end
  end

  describe "GET #show" do
    it "routes correctly" do
      #p = Problem.new
      expect(Problem).to receive(:find).with("1") { @problem1 }
      get :show, id: 1
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      expect(Problem).to receive(:find).with("1") { @problem1 }
      get :show, id: 1
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    it "should redirect to index on sucess" do
      #post :create, attempt: attributes_for(:attempt)
      p = Problem.new
      Problem.should_receive(:new).and_return(p)
      p.should_receive(:save).and_return(true)
      post :create, { :problem => { "name"=>"dummy", "question"=>"test" } }
      response.should redirect_to(problems_path)
    end
    it "should redirect to create problem on failure" do
      p = Problem.new
      Problem.should_receive(:new).and_return(p)
      p.should_receive(:save).and_return(false)
      post :create, { :problem => { "name"=>"dummy", "question"=>"test" } }
      response.should redirect_to(new_problem_path)
    end
  end
end
