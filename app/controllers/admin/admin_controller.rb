class Admin::AdminController < ApplicationController
    before_filter :require_login, :require_admin

	def index
		
		if(params.has_key?(:event))
		 
			event_date = params[:event]
			if (Event.exists?)
		 		stored_date = Event.find(1)
		 		stored_date.update_attributes(:day => event_date["date(3i)"], :month => event_date["date(2i)"], :year => event_date["date(1i)"] )
		 		@event_date_set = Date.new stored_date[:year].to_i, stored_date[:month].to_i, stored_date[:day].to_i

			else
				stored_date = Event.create(:day => event_date["date(3i)"], :month => event_date["date(2i)"], :year => event_date["date(1i)"] )
				@event_date_set = Date.new stored_date[:year].to_i, stored_date[:month].to_i, stored_date[:day].to_i
			end
		
		else
			if(Event.exists?)
				stored_date = Event.find(1)
				@event_date_set = Date.new stored_date[:year].to_i, stored_date[:month].to_i, stored_date[:day].to_i
			end
			
		end
		render 'admin/index.html'
	end
	
	
	
	def reset 
		render 'admin/reset.html'
		@judge = Judge.find(1)			
	end

	def reset_pw
		if (params[:new_pw] == params[:confirm_pw])
			flash[:notice] = "Password updated"
			@current_user.update_attributes(access_code: params[:new_pw])
		else
			flash[:error] = "Passwords don't match"
		end
		redirect_to admin_reset_path
	end
end
