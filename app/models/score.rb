class Score < ActiveRecord::Base
	#attr_accessible :novelty, :utility, :difficulty, :verbal, :written, :no_show
	belongs_to :judge, counter_cache: true
	belongs_to :poster, counter_cache: true
	#attr_accessible :judge_id, :poster_id
    def self.score_terms
       %w(novelty utility difficulty verbal written)
    end
    
    def self.assign_poster_to_judge(poster, judge)
        score = judge.scores.build(novelty: -1, utility: -1, difficulty: -1, verbal: -1, written: -1)
        poster.scores << score
        score.save!
    end

    def self.get_score_sum
        str = ""
        score_terms.each do |term|
             str += term + "+"
        end
        str.gsub(/\+$/, " ")
        str += "as score_sum"
        Score.select(str)
    end

    def self.get_poster_avg(poster)
        score_sum = Score.get_score_sum.where(poster_id: poster.id)
        poster_sum = score_sum.group(:poster_id).sum(:score_sum)
        poster_avg = poster_sum/poster.judges.size.to_f
        poster_avg /= score_terms.size.to_f
        return poster_avg
    end
end

