require 'csv'

class Admin::PostersController < ApplicationController
        before_filter :require_login

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

    def create_rank_file(posters, scores)
        File.delete("app/downloads/rankings.csv") if File.exists?("app/downloads/rankings.csv")
        CSV.open("app/downloads/rankings.csv", "wb") do |csv|
            csv << ["rank", "presenter", "title", "score"]
            rank = 1
            for poster in posters
                csv << [rank, poster.presenter, poster.title, scores[poster.number]]
                rank += 1
            end
        end
    end

	def rankings
        scores = Score.joins(:judge, :poster)
        @posters = Poster.find(:all)
        @avg_scores = Hash.new(0.0)

        for score in scores  
            score = (score.novelty + score.utility + score.difficulty + score.verbal + score.written)
            total = score/5.0
            if(score.no_show || score < 5.0)
                total = 0.0
            end
            
            @avg_scores[score.poster.number] = @avg_scores[score.poster.number] + total
        end
		
		if scores.empty? == false
        	for poster in @posters
            	@avg_scores[poster.number] = (@avg_scores[poster.number])/(poster.scores_count)
        	end
		end
        
        @posters = @posters.sort_by{|poster| @avg_scores[poster.number]}.reverse

        create_rank_file(@posters, @avg_scores)
    end

    def download
        File.delete("app/downloads/posters.csv") if File.exists?("app/downloads/posters.csv")
        @posters = Poster.find(:all)
        CSV.open("app/downloads/posters.csv", "wb") do |csv|
            csv << ["number","presenter","title","advisors"]
            for poster in @posters
                csv << [poster.number, poster.presenter, poster.title, poster.advisors]
            end
        end
        send_file("app/downloads/posters.csv")
    end

    def download_ranks
        send_file("app/downloads/rankings.csv", :filename => "rankings.csv")
    end
end
