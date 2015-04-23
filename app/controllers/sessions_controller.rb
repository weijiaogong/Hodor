class SessionsController < ApplicationController
  def new

  end

  def create
    puts params[:session][:password]
    judge = Judge.where(access_code: params[:session][:password]).first
    if judge
      sign_in judge
      redirect_to judge_register_path(judge.id)
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
