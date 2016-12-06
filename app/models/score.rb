class Score < ApplicationRecord
	#attr_accessor :novelty, :utility, :difficulty, :verbal, :written, :no_show
	belongs_to :judge, counter_cache: true
	belongs_to :poster, counter_cache: true
	#attr_accessor :judge_id, :poster_id
	
	
	
    def self.score_terms
       %w(novelty utility difficulty verbal written)
    end
    
    def self.assign_poster_to_judge(poster, judge)
        score = Score.find_by(poster_id: poster.id, judge_id: judge.id)
        unless score
            score = judge.scores.build(novelty: -1, utility: -1, difficulty: -1, verbal: -1, written: -1)
            poster.scores << score
            score.save!
        end
    end

    def self.get_score_sum
        str = "("
        score_terms.each do |term|
             str += term + "+"
        end
        str = str.gsub(/\+\z/, ") ") + "as score_sum"
        return Score.select(str)
    end

end

