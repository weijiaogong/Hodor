class PostersController < ApplicationController
    before_filter :require_login
    #render the view for judging each poster
    def judge
        @poster = Poster.find(params[:poster_id])
        @judge = Judge.find(params[:judge_id])
    end    
    
    #update the Score associated with a specific poster and a specific judge
    def update
        #check to make sure all radio buttons are checked

        @score = Score.where(judge_id: params[:judge_id], poster_id: params[:id]).first()

        @score.update_attributes(:novelty => params[:score][:novelty].to_i, :utility => params[:score][:utility].to_i, :difficulty => params[:score][:difficulty].to_i, :verbal => params[:score][:verbal].to_i, :written => params[:score][:written].to_i, :no_show => false)

        redirect_to judge_path(params[:judge_id])

    end

    def no_show
        @score = Score.where(judge_id: params[:judge_id], poster_id: params[:poster_id]).first()

        @score.update_attributes(:no_show => true)

        redirect_to judge_path(params[:judge_id])

    end
end
