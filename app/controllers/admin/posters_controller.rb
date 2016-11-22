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
			
			#RemindMailer.remind_email.deliver_later(wait_until: 1.minutes.from_now)
			
			#SendEmailJob.set(wait: 60.seconds).perform_later
			#RemindMailer.delay(run_at: 1.minutes.from_now).remind_email
    		RemindMailer.call_remind_email
    		#RemindMailer.remind_email.deliver_later(wait_until: 1.minutes.from_now)
    		#end
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
        vals = @posters.attribute_names
        puts vals.to_s
        CSV.open("app/downloads/posters.csv", "wb") do |csv|
            csv << vals
            for poster in @posters
            	puts vals.methods
            	csv << vals.map{ |v| poster.send(v) }
            end
        end
        send_file("app/downloads/posters.csv")
    end
end
