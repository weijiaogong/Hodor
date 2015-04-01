require 'csv'

class Admin::PostersController < ApplicationController
	def index
		@posters = Poster.all
	end
	
	def import
		CSV.foreach(params[:file].path, headers: true, encoding: 'windows-1251:utf-8') do |row|
			poster = Poster.where(number: row['number'])
			if poster.count == 1
				poster.first.update_attributes(row.to_hash)
			else
				Poster.create(row.to_hash)
			end
		end
		redirect_to admin_posters_path
	end
end
