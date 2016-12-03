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
        vals = @posters.attribute_names.reject { |a| ['id', 'scores_count', 'no_show', 'number'].include?(a) }
        CSV.open("app/downloads/posters.csv", "wb") do |csv|
            csv << vals
            for poster in @posters
            	csv << vals.map{ |v| poster.send(v) }
            end
        end
        send_file("app/downloads/posters.csv")
    end
    
    def set_maximum
    	
    	redirect_to admin_posters_path, :notice => "Set successfully"
    end
end
