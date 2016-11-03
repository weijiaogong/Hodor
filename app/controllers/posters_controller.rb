class PostersController < ApplicationController
    before_filter :require_login, :except => [:new, :create]
    #render the view for judging each poster
    def judge
        @poster = Poster.find(params[:poster_id])
        @judge = Judge.find(params[:judge_id])
    end    
    
    def new
    end
    
    def create  #what if the admin wants to create a poster? then bulk load from csv
        @poster = Poster.create!(params[:poster].permit(:number, :presenter, :title, :advisors, :scores_count, :email))
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
        @poster.update_attributes!(params[:poster].permit(:number, :presenter, :title, :advisors, :scores_count, :email))
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
