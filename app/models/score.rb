class Score < ActiveRecord::Base
	#attr_accessible :novelty, :utility, :difficulty, :verbal, :written, :no_show
	belongs_to :judge, counter_cache: true
	belongs_to :poster, counter_cache: true
	#attr_accessible :judge_id, :poster_id
end


