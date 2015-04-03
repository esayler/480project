class Attempt < ActiveRecord::Base
    belongs_to :user
    belongs_to :problem

    validates :user_id, :problem_id, :submission, presence: true
end
