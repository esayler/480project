require 'rails_helper'

RSpec.describe ProblemsController, :type => :controller do
	describe "GET #index" do
    	it "routes correctly" do
      		get :index
      		expect(response.status).to eq(200)
    	end
    	it "renders the index template show all problems" do
      		x, y = Problem.create!, Problem.create!
      		expect(Product).to receive(:find).with(:all) { [x,y] }
      		get :index
      		expect(response).to render_template(:index)
      		expect(assigns(:problems)).to match_array([x,y])
    	end
    end
    describe "GET #show" do
    	it "routes correctly" do
    		p = Problem.new
      		expect(Problem).to receive(:find).with("1") { p }
      		get :show, id: 1
      		expect(response.status).to eq(200)
    	end

    	it "renders the show template" do
      		expect(Product).to receive(:find).with("1") { p }
      		get :show, id: 1
      		expect(response).to render_template(:show)
    	end
  	end

  	describe "POST #create" do
    	it "should redirect to index on sucess" do
      		p = Problem.new
      		Problem.should_receive(:new).and_return(p)
      		p.should_receive(:save).and_return(true)
      		post :create, { :product => { "name"=>"dummy", "question"=>"test" } }
      		response.should redirect_to(problems_path)
    	end
  	end
end
