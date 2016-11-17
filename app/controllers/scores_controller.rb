class ScoresController < ApplicationController
    before_action :require_login
    #render the view for judging each poster
    def edit
        @poster = Poster.find(params[:poster_id])
        @judge = Judge.find(params[:judge_id])
        @no_show = decide_no_show
    end
    
    #update the Score associated with a specific poster and a specific judge
    def update
        #check to make sure all radio buttons are checked
        
        judge_id  = params[:judge_id]
        poster_id = params[:poster_id]
        @score = Score.where(judge_id: judge_id, poster_id: poster_id).first()
        score = params[:score]
        score = score.map {|k,v| k, v = k.to_sym, v.to_i}.to_h  #FIXME deprecated (can we use transform_values()?)
        poster = Poster.find(poster_id)
        begin
            if poster.no_show
                @poster.update_attribute(:no_show, false)
            end
            @score.update_attributes!(score)
            flash[:notice] = "Score is submitted successfully"
            if admin?
              redirect_to admin_score_path(poster_id)
            else
              redirect_to judge_path(judge_id)
            end
        rescue ActiveRecord::RecordInvalid => invalid
           flash[:notice] = invalid
           redirect_to edit_judge_score_path(judge_id, poster_id)
        end

    end
   
    def decide_no_show
        no_show = true
        @poster.scores.each do |score|
            sum = Score.get_score_sum.find(score.id).score_sum
            if sum > 0
               no_show = false
               break
            end
        end
        return no_show
    end
    

    def no_show
        @poster = Poster.find(params[:score_poster_id])
        @poster.update_attribute(:no_show, decide_no_show)
        redirect_to judge_path(params[:judge_id])
    end
    
    
	
    def accept
        judge_id  = params[:judge_id]
        poster_id = params[:score_poster_id]
        poster = Poster.find(poster_id)
        @judge = Judge.find(judge_id)
        Score.assign_poster_to_judge(poster, @judge)
        redirect_to edit_judge_score_path(judge_id, poster_id)
    end
end
