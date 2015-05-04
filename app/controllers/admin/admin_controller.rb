class Admin::AdminController < ApplicationController
    before_filter :require_login

	def index
		render 'admin/index.html'
	end
end
