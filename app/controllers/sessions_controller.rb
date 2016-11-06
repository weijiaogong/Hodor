class SessionsController < ApplicationController
  before_filter :sign_out_check, only: [:destroy]

  def sign_out_check
    @unscored = false
    if current_user.role == "judge"
      scores = current_user.scores
      scores.each do |score|
        sum = Score.get_score_sum().find(score.id).score_sum
        puts score.id.to_s + " " + score.poster_id.to_s + " " + sum.to_s
        if sum < 0
           @unscored = true
        end
      end
    end
  end
  
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
