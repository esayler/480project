describe Attempt do
    
    it 'is valid with a user_id, problem_id, and submission' do
        attempt = build(:attempt)
        expect(attempt).to be_valid
    end

    it 'is invalid without a user_id' do
        attempt = build(:attempt, user_id: nil)
        expect(attempt).to_not be_valid
    end

    it 'is invalid without a problem_id' do
        attempt = build(:attempt, problem_id: nil)
        expect(attempt).to_not be_valid
    end

    it 'is invalid without a submission' do
        attempt = build(:attempt, submission: nil)
        expect(attempt).to_not be_valid
    end
end
