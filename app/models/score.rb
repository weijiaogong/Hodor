class Poster < ActiveRecord::Base
	attr_accessible :novelty, :utility, :difficulty, :verbal, :written, :no_show
	belongs_to :judge
	belongs_to :poster
end


