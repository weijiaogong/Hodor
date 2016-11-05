require 'csv'

class Admin::PostersController < ApplicationController
        before_filter :require_login, :require_admin

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

    def download
        File.delete("app/downloads/posters.csv") if File.exists?("app/downloads/posters.csv")
        @posters = Poster.all
        CSV.open("app/downloads/posters.csv", "wb") do |csv|
            csv << ["number","presenter","title","advisors"]
            for poster in @posters
                csv << [poster.number, poster.presenter, poster.title, poster.advisors]
            end
        end
        send_file("app/downloads/posters.csv")
    end
end
