require 'rails_helper'

RSpec.describe AttemptsController, :type => :controller do
  describe "GET #index" do
    it "routes correctly" do
      get :index
      expect(response.status).to eq(200)
    end
	it "renders the index template show all attempts grouped by problem" do
      x, y = Attempt.create!, Attempt.create!
      expect(Attempt).to receive(:all) { [x,y] }
  	  get :index
      expect(response).to render_template(:index)
      expect(assigns(:attempts)).to match_array([x,y])
    end
  end

end
