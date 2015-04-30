describe ProblemPolicy, :pundit do
  subject { ProblemPolicy }

  let (:student) { FactoryGirl.build_stubbed :user, :student }
  let (:other_student) { FactoryGirl.build_stubbed :user, :student }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:alum) { FactoryGirl.build_stubbed :user, :alum }
  let (:prof) { FactoryGirl.build_stubbed :user, :prof }

  permissions :index? do
    it "allows access for a student" do
      expect(subject).to permit(student)
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your profile" do
      expect(subject).not_to permit(student, other_student)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(student, student)
    end
    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(student)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting yourself" do
      expect(subject).not_to permit(student, student)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin, other_student)
    end
  end

end
