class Judge < ActiveRecord::Base
	attr_accessible :name, :company_name, :access_code, :scores_count
	has_many :scores
	has_many :posters, through: :scores

        before_save :create_remember_token

	def self.assign_poster(poster_id, judge_id)
        @judge = Judge.find(judge_id)
	    @judge.scores.create!(judge_id: judge_id, poster_id: poster_id, no_show: false, novelty: -1, utility: -1, difficulty: -1, verbal: -1, written: -1)
	end

        private
          def create_remember_token
            self.remember_token = SecureRandom.urlsafe_base64
          end
end
