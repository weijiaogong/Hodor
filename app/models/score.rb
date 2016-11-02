class Score < ActiveRecord::Base
	#attr_accessible :novelty, :utility, :difficulty, :verbal, :written, :no_show
	belongs_to :judge, counter_cache: true
	belongs_to :poster, counter_cache: true
	#attr_accessible :judge_id, :poster_id
	
    def self.assign_poster_to_judge(poster, judge)
        score = judge.scores.build(novelty: -1, utility: -1, difficulty: -1, verbal: -1, written: -1)
        poster.scores << score
        score.save!
    end
end


