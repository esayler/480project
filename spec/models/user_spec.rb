describe User do
  
 context "when email is non-empty" do
    it "should be valid" do
      user = User.new(email: 'changeme@changeme.com')
      expect(user).to be_valid
    end
 end
  context "when email is blank" do
    it "should not be valid" do
      user = User.new(email: " ")
      expect(user).to_not be_valid
    end
  end
end
