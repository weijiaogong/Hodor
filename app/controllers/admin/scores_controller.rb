class Admin::ScoresController < ApplicationController
        before_filter :require_login, :require_admin
	def index
		@scores = Score.joins(:judge, :poster)
		@scores = @scores.sort_by{|score| score.poster.number}
	end
end
