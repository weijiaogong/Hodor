class Admin::AdminController < ApplicationController
    before_filter :require_login, :require_admin

	def index
		render 'admin/index.html'
	end
end
