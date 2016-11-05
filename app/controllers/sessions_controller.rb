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
    if current_user.role == "judge"
       unless current_user.leave
          redirect_to judge_leave_path(current_user)
          return
       end
    end
    sign_out
    redirect_to root_url
  end

end
