class Admin::ScoresController < ApplicationController
	def index
		@scores = Score.joins(:judge, :poster)
		@scores = @scores.sort_by{|score| score.poster.number}
	end
end
