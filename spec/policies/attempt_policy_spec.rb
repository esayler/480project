describe AttemptPolicy, :pundit do
  subject { AttemptPolicy }

  let (:student) { FactoryGirl.build_stubbed :user, :student }
  let (:other_student) { FactoryGirl.build_stubbed :user, :student }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:alum) { FactoryGirl.build_stubbed :user, :alum }
  let (:prof) { FactoryGirl.build_stubbed :user, :prof }

  permissions :index? do
    it "allows access for an admin" do
      expect(subject).to permit(admin)
    end
    it "allows access for a student" do
      expect(subject).to permit(student)
    end
    it "allows access for a alum" do
      expect(subject).to permit(alum)
    end
    it "allows access for a prof" do
      expect(subject).to permit(prof)
    end
  end

  permissions :show? do
    it "allows other students to see student attempts" do
      expect(subject).to permit(student, other_student)
    end
    it "allows a student to see their attempt" do
      expect(subject).to permit(student, student)
    end
    it "allows an admin to see any attempt" do
      expect(subject).to permit(admin)
    end
    it "allows an alum to see any attempt" do
      expect(subject).to permit(alum)
    end
    it "allows a prof to see any attempt" do
      expect(subject).to permit(prof)
    end
  end

  #permissions :new? do
  #end

  permissions :create? do
    it "allows an admin to create an attempt" do
      expect(subject).to permit(admin)
    end
    it "allows a student to create an attempt" do
      expect(subject).to permit(student)
    end
    it "allows an alum to create an attempt" do
      expect(subject).to permit(alum)
    end
    it "allows an prof to create an attempt" do
      expect(subject).to permit(prof)
    end
  end

  #permissions :edit? do
  #end

  permissions :update? do
    it "denies a student from editing or grading an attempt" do
      expect(subject).not_to permit(student)
    end
    it "allows an admin to update (grade) an attempt" do
      expect(subject).to permit(admin)
    end
    it "allows an prof to update (grade) an attempt" do
      expect(subject).to permit(admin)
    end
    it "allows an alum to update (grade) an attempt" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows an admin to delete any attempt" do
      #TODO: admin to other_student ???
      expect(subject).to permit(admin, other_student)
    end
    it "prevents a student from deleting an attempt", :skip => "not implemented yet" do
      #TODO: student to student ???
      expect(subject).not_to permit(student, student)
    end
    it "prevents an alum from deleting an attempt", :skip => "not implemented yet" do
      #TODO: alum to student ???
      expect(subject).not_to permit(alum, student)
    end
    it "prevents a prof from deleting an attempt", :skip => "not implemented yet" do
      #TODO: prof to student ???
      expect(subject).not_to permit(prof, student)
    end
  end

end
