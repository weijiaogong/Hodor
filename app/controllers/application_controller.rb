class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def handle_unverified_request
    sign_out
    super
  end
  
  def signout_check
    @no_confirm = true
    if current_user.role  == "judge"
      current_user.scores.each do |score|
          first_score = score.send(Score.score_terms[0])
          if first_score < 0 && !score.no_show
            @no_confirm = false
            #@judge = current_user
          end
      end
    end
    render json: @no_confirm
  end
  
  
end
