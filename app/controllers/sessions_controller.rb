class SessionsController < ApplicationController

  def new

  end

  def create
    puts params[:session][:password]
    judge = Judge.where(access_code: params[:session][:password]).first
    
    if judge
      sign_in judge
      if admin
        redirect_to admin_root_path
      else
        if judge.name && judge.company_name
          redirect_to judge_path(judge.id)
        else
          redirect_to judge_register_path(judge.id)
        end
      end
    else
      flash.now[:error] = 'Invalid password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
