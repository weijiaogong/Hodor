class SessionsController < ApplicationController

  def new

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

end
