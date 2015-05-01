class Attempt < ActiveRecord::Base

    belongs_to :user
    belongs_to :problem

    validates :user_id, :problem_id, :grade, :submission, presence: true
    validates_numericality_of :grade, :only_integer => true
    validates :grade, inclusion: { in: -1..10, message: "%{value} is not a valid grade" }
    validates_associated :user, :problem

    def show_grade
      if self.grade == -1
        "Not yet graded"
      else
        self.grade.to_s
      end
    end

end
