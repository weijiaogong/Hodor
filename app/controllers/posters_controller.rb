class PostersController < ApplicationController
    before_filter :require_login, :except => [:new, :create]

    def index
        redirect_to new_poster_path
    end

    def new
    end
    
    def create  #what if the admin wants to create a poster? then bulk load from csv
        @poster = Poster.create(params[:poster].permit(:number, :presenter, :title, :advisors, :scores_count, :email))
        if @poster.errors.messages.empty?
            flash[:notice] = "#{@poster.title} was successfully created."
            redirect_to root_path and return
        else
            flash[:error] = "Please correct the following fields: #{@poster.errors.messages.keys.join(', ')}"
            render :action => 'new' #and now the css breaks :(
        end
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

end
