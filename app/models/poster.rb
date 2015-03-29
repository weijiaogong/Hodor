# :judges -> the number of judges currently assigned to this poster
# (:novelty, :utility, :difficulty, :verbal, :written) -> the judging criteria
# these are the total (unaveraged) score given to the poster by the judges
class Poster < ActiveRecord::Base
	attr_accessible :id, :presenter, :title, :advisors, :judges,
		:novelty, :utility, :difficulty, :verbal, :written
end
