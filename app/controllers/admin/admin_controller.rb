class Admin::AdminController < ApplicationController
    before_action :require_login, :require_admin

	def index
		
		if(params.has_key?(:event))
		 
			event_date = params[:event]
			if (Event.exists?)
				@event_date_set = Date.strptime(event_date[:date], '%Y-%m-%d')
				stored_date = Event.find(1)
				stored_date.update_attributes(:day => @event_date_set.mday, :month => @event_date_set.mon, :year => @event_date_set.year )

		 		#stored_date = Event.find(1)
		 		#stored_date.update_attributes(:day => event_date["date(3i)"], :month => event_date["date(2i)"], :year => event_date["date(1i)"] )
		 		#@event_date_set = Date.new stored_date[:year].to_i, stored_date[:month].to_i, stored_date[:day].to_i

			else
				@event_date_set = Date.strptime(event_date[:date], '%Y-%m-%d')
				stored_date = Event.create(:day => @event_date_set.mday, :month => @event_date_set.mon, :year => @event_date_set.year )
				#@event_date_set = Date.new stored_date[:year].to_i, stored_date[:month].to_i, stored_date[:day].to_i
			end
		
		else
			if(Event.exists?)
				stored_date = Event.find(1)
				@event_date_set = Date.new stored_date[:year].to_i, stored_date[:month].to_i, stored_date[:day].to_i
			end
			
		end
		
	    unless File.exists?("app/assets/images/qrcode.png")
	      qr = RQRCode::QRCode.new( 'https://iap-poster-app.herokuapp.com').to_img.resize(400, 400)
	      #@qrcode = qr.to_data_url    # returns an instance of ChunkyPNG
	      qr.save("app/assets/images/qrcode.png")
	    end
    
		render 'admin/index.html'
	end
	
	
	
	def reset 
		render 'admin/reset.html'
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
	
	def register
        @judge = Judge.find(params[:judge_id])
        render 'admin/register.html'
    end
    
    def registerup
    	@judge = Judge.find(params[:judge_id])
        res = @judge.update_attributes(name: params[:name], company_name: params[:company])
        # this validation should be down in js
        unless res
          flash[:error] = "name & company_name cannot be blank"
          redirect_to admin_register_path(@judge) and return
        end
        sign_in @judge
        redirect_to admin_root_path
    end
end
