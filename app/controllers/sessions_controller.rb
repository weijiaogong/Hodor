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
  
  
  def signout
    @no_confirm = true
    if current_user.role  == "judge"
      current_user.scores.each do |score|
          first_score = score.send(Score.score_terms[0])
          if first_score < 0 && !score.no_show
            @no_confirm = false
            @judge = current_user
          end
      end
    end
    render :json => @no_confirm
  end
  
  
end
