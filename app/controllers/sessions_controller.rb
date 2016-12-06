#require 'rqrcode_png'
class SessionsController < ApplicationController
  def new
    if not current_user.nil? and admin?
      redirect_to admin_root_path and return
    end

  end

  def create
    judge = Judge.find_by_access_code(params[:session][:password])
    session[:password] = params[:session][:password]

    if judge
      sign_in judge
      main_page(judge)
    else
      redirect_to(signin_path, :alert => 'Invalid password') and return
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def download
        send_file("app/assets/images/qrcode.png",:filename => "qrcode.png")
  end
  
  
end
