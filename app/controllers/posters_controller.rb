class PostersController < ApplicationController
    before_filter :require_login, :except => [:new, :create]
    #render the view for judging each poster
    def edit
        @poster = Poster.find(params[:id])
        @judge = Judge.find(params[:judge_id])
    end    
    
    def new
    end
    
    def create  #what if the admin wants to create a poster? then bulk load from csv
        @poster = Poster.create!(params[:poster])
        flash[:notice] = "#{@poster.title} was successfully created."
        redirect_to root_path
    end

    def edit
        @poster = Poster.find params[:id]
        rescue ActiveRecord::RecordNotFound   #not dry- move to poster model
            flash[:notice] = "No such poster"
            redirect_to admin_posters_path and return
    end
    
    def update
        @poster = Poster.find params[:id]
#        rescue ActiveRecord::RecordNotFound
#            flash[:notice] = "No such poster"
#            redirect_to admin_posters_path and return
        @poster.update_attributes!(params[:poster])
        flash[:notice] = "#{@poster.title} was successfully updated."
        redirect_to admin_posters_path
    end
    
    def destroy #TODO how to ensure only admin can delete?
        @poster = Poster.find(params[:id])
        @poster.destroy
        flash[:notice] = "Poster deleted."
        redirect_to admin_posters_path
    end
    
    #update the Score associated with a specific poster and a specific judge
    def update_score    #FIXME this method does not fit here. judges submit scores
        #check to make sure all radio buttons are checked
        
        judge_id  = params[:judge_id]
        poster_id = params[:id]
        @score = Score.where(judge_id: judge_id, poster_id: poster_id).first()
        score = params[:score]
        score = score.map {|k,v| k, v = k.to_sym, v.to_i}.to_h
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
           redirect_to score_judge_path(judge_id, poster_id)
        end

    end
   
    def decide_no_show
        no_show = true
        score_terms = Score.score_terms
        @poster.scores.each do |score|
            score_terms.each do |term|
                if score[term] > 0
                    no_show = false
                    break
                end
            end
        end
        return no_show
    end
    

    def no_show
        @poster = Poster.find(params[:poster_id])
        @poster.update_attribute(:no_show, decide_no_show)
        redirect_to judge_path(params[:judge_id])
    end
end
