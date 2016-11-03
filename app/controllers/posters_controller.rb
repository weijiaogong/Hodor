class PostersController < ApplicationController
    before_filter :require_login
    #render the view for judging each poster
    def edit
        @poster = Poster.find(params[:id])
        @judge = Judge.find(params[:judge_id])
    end    
    
    #update the Score associated with a specific poster and a specific judge
    def update
        #check to make sure all radio buttons are checked

        judge_id  = params[:judge_id]
        poster_id = params[:id]
        @score = Score.where(judge_id: judge_id, poster_id: poster_id).first()

        score = params[:score]
        score = score.map {|k,v| k, v = k.to_sym, v.to_i}.to_h
        
        begin
            @score.update_attributes!(score)
            flash[:notice] = "Score is submitted successfully"
            if admin?
              redirect_to admin_score_path(poster_id)
            else
              redirect_to judge_path(judge_id)
            end
        rescue ActiveRecord::RecordInvalid => invalid
           flash[:notice] = invalid
           redirect_to score_judge_path(judge_id, poster_id)
        end

    end

    def no_show
        @score = Score.where(judge_id: params[:judge_id], poster_id: params[:poster_id]).first()

        @score.update_attributes(:no_show => true)

        redirect_to judge_path(params[:judge_id])

    end
end
