describe User do

  it 'is valid with a name and email' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without a email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
  end

  it 'is invalid with a duplicate email' do
      create(:user)
      user = build(:user)
      expect(user).to_not be_valid
  end

end
