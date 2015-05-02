require 'csv'

class Admin::PostersController < ApplicationController
	def index
		@posters = Poster.all
	end
	
	def import
		@file = params[:file]
		if @file.blank?
			redirect_to admin_posters_path, :notice => "File missing"
		elsif File.extname(@file.original_filename) == ".csv"
			Poster.import_csv(@file)
			redirect_to admin_posters_path, :notice => "Import successful"
		else
			redirect_to admin_posters_path, :notice => "Invalid file extension"
		end
	end

	def clear
		Poster.destroy_all
		redirect_to admin_posters_path
	end

	def rankings
        scores = Score.joins(:judge, :poster)
        @posters = Poster.find(:all)
        @avg_scores = Hash.new(0.0)

        for score in scores  
            total = (score.novelty + score.utility + score.difficulty + score.verbal + score.written)/5.0
            if(score.no_show)
                total = 0.0
            end
            
            @avg_scores[score.poster.number] = @avg_scores[score.poster.number] + total
        end

        for poster in @posters
            @avg_scores[poster.number] = (@avg_scores[poster.number])/(poster.scores_count)
        end
        
        @posters = @posters.sort_by{|poster| @avg_scores[poster.number]}.reverse
    end
end
