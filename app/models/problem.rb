class Problem < ActiveRecord::Base
    belongs_to :user
    has_many :attempts

    validates :name, :difficulty, :user_id, :description, presence: true
end
