class Admin::PostersController < ApplicationController
	def index
		@posters = Poster.find(:all, :order => "score DESC")
	end
	
	def import
		file = params[:file].read
		CSV.parse(file) do |row|
			Poster.create!(row.to_hash)
		end
	end
end