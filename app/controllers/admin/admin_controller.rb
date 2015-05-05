class Admin::AdminController < ApplicationController
    before_filter :require_login, :require_admin

	def index
		render 'admin/index.html'
	end

	def reset 
		render 'admin/reset.html'
		@judge = Judge.find(1)			
	end

	def reset_pw
		if (params[:new_pw] == params[:confirm_pw])
			flash[:notice] = "Password updated"
			Judge.find(1).update_attributes(access_code: params[:new_pw])
		else
			flash[:error] = "Passwords don't match"
		end
		redirect_to admin_reset_path
	end
end
