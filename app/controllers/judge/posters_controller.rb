class Judge::PostersController < ApplicationController
	
	#will find a poster with the lowest number of judges
	def index
		@poster = Poster.first.order('judges asc')
		redirect_to edit_poster_path(@poster)
	end
	
	def edit
		@poster = Movie.find(params[:id])
	end
	
	#only update the score
	def update
		@poster = Poster.find(params[:id])
		@poster.update_attribute!(:score, params[:id][:score])
	end
end