class Attempt < ActiveRecord::Base

    belongs_to :user
    belongs_to :problem

    validates :user_id, :problem_id, presence: true

    def show_grade
      if self.grade == -1
        "Not yet graded"
      else
        self.grade.to_s
      end
    end

end
