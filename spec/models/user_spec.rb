describe User do
  
  it "should be valid" do
    user = User.new
    expect(user).to be_valid
  end

end
