require 'rails_helper'

RSpec.describe AttemptsController, :type => :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    user = double('user')
    user.stub(:id).and_return(1)
    allow(controller).to receive(:current_user){ user }
  end
  describe "GET #index" do
    it "routes correctly" do
      get :index,{:problem_id => 1}
      expect(response.status).to eq(200)
    end
	it "renders the index template show all attempts grouped by problem" do
      x, y = Attempt.create!, Attempt.create!
      expect(Attempt).to receive(:all) { [x,y] }
  	  get :index,{:problem_id => 1}
      expect(response).to render_template(:index)
      expect(assigns(:attempts)).to match_array([x,y])
    end
  end

  
  describe "GET #show" do
   	it "routes correctly" do
      a = Attempt.new
      expect(Attempt).to receive(:find).with("1") { a }
      get :show,{:problem_id => 1}
      expect(response.status).to eq(200)
    end

  it "renders the show template" do
      expect(Attempt).to receive(:find).with("1") { a }
      get :show,{:problem_id => 1}
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    it "should redirect to index on success" do
      #@problem = Problem.find(params[:id])
      a = Attempt.new
      Attempt.should_receive(:new).and_return(a)
      a.should_receive(:save).and_return(true)
      post :create, { :attempt => { "user_id"=>1, "problem_id"=>1, "submission" => "my best guess" } }
      response.should redirect_to(problems_path)#TODO
      expect(response).to have_content("Attempt successfully submitted")
    end


    it "should redirect back to new template on failure and flash a warning" do
      a = Attempt.new
      Attempt.should_receive(:new).and_return(a)
      a.should_receive(:save).and_return(true)
      post :create, { :attempt => { "user_id"=>-1, "problem_id"=>-1, "submission" => "my best guess" } }
      response.should redirect_to(problems_path)#TODO
      expect(response).to have_content("Attempt failed to be submitted")
    end
  end
end
