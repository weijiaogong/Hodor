require 'csv'

class Admin::PostersController < ApplicationController
	def index
		@posters = Poster.order(score: :desc)
	end
	
	def import
		@file = params[:file]
		if @file.blank?
			redirect_to admin_posters_path, :notice => "File missing"
		elsif @file.content_type == "text/csv"
			CSV.foreach(@file.path, headers: true, encoding: 'windows-1251:utf-8') do |row|
				poster = Poster.where(number: row['number'])
				if poster.count == 1
					poster.first.update_attributes(row.to_hash)
				else
					Poster.create(row.to_hash)
				end
			end
			redirect_to admin_posters_path, :notice => "Import successful"
		else
			redirect_to admin_posters_path, :notice => "Invalid file extension"
		end
	end
end
