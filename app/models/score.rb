class Score < ActiveRecord::Base
	attr_accessible :novelty, :utility, :difficulty, :verbal, :written, :no_show
	belongs_to :judge
	belongs_to :poster
	attr_accessible :judge_id, :poster_id
end


