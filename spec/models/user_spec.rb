describe User do

  describe "when email is non-empty" do

    it "should be valid" do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end

  end

  describe "when email is blank" do

    it "should not be valid" do
      user = FactoryGirl.build(:user, email: nil)
      expect(user).to_not be_valid
    end

  end

end
