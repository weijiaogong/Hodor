require 'rqrcode_png'
class SessionsController < ApplicationController
  def new
    unless File.exists?("app/assets/images/qrcode.png")
      qr = RQRCode::QRCode.new( 'https://iap-poster-app.herokuapp.com').to_img.resize(400, 400)
      #@qrcode = qr.to_data_url    # returns an instance of ChunkyPNG
      qr.save("app/assets/images/qrcode.png")
    end
  end

  def create
    judge = Judge.find_by_access_code(params[:session][:password])

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

  def signout
    no_confirm = true
    if current_user.role  == "judge"
      current_user.scores.each do |score|
          sum = Score.get_score_sum.find(score.id).score_sum
          if sum < 0
            no_confirm = false
            @judge = current_user
          end
      end
    end
    if no_confirm
      sign_out
      redirect_to root_url
    end
  end
  
  def download
        send_file("app/assets/images/qrcode.png",:filename => "qrcode.png")
  end
end
