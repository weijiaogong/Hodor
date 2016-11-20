require 'csv'

class Admin::PostersController < ApplicationController
        before_action :require_admin

	def index
		@posters = Poster.all
	end
	
	def import
		@file = params[:file]
		if @file.blank?
			redirect_to admin_posters_path, :notice => "File missing"
		elsif File.extname(@file.original_filename) == ".csv"
			message = Poster.import(CSV.read(@file.path, headers: true, encoding: 'windows-1251:utf-8'))
			redirect_to admin_posters_path, :notice => message
			#Poster.find_each do |poster|
    		#		RemindMailer.remind_email(poster).deliver_now
    		#	end
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
