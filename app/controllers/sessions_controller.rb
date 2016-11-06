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
  
end
