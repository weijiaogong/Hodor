class Poster < ActiveRecord::Base
	attr_accessible :number, :presenter, :title, :advisors, :score, :judges
end
