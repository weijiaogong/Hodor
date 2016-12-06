class ScoresController < ApplicationController
    before_action :require_login
    #render the view for judging each poster
    def decide_no_show
        no_show = true
        @poster.scores.each do |score|
            no_show = false unless score.no_show
        end
        return no_show
    end
    def edit
        @poster = Poster.find(params[:poster_id])
        @judge = Judge.find(params[:judge_id])
        if !@judge.posters.include?(@poster)
            flash[:notice] = "#{@poster.title} was not assigned to #{@judge.name}."
            redirect_to judge_path(@judge)
        end
        @no_show = decide_no_show
    end
    
    #update the Score associated with a specific poster and a specific judge
    def update
        #check to make sure all radio buttons are checked
        
        judge_id  = params[:judge_id]
        poster_id = params[:poster_id]
        @score = Score.where(judge_id: judge_id, poster_id: poster_id).first()
        score = params[:score]
        score = score.map {|k,v| k, v = k.to_sym, v.to_i}.to_h
        #poster = Poster.find(poster_id)
        if @score.no_show
            score[:no_show] = false
        end
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
           redirect_to edit_judge_score_path(judge_id, poster_id)
        end

    end

    

    def no_show
        poster_id = params[:score_poster_id]
        judge_id = params[:judge_id]
        score = Score.find_by(judge_id: judge_id, poster_id: poster_id)
        begin
            score.update_attributes!(novelty: -1, utility: -1, difficulty: -1, verbal: -1, written: -1, no_show: true)
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
        #create 2 - 3 new Scores for each poster assigned to this judge
    def assign
        judge ||= Judge.find(params[:judge_id])
        poster = Poster.find(params[:score_poster_id])
        if  poster
            Score.assign_poster_to_judge(poster, judge)
            flash[:notice] = "You have successfully added poster #" + poster.number.to_s
        end
        redirect_to judge_path(params[:judge_id])
    end
    
end
