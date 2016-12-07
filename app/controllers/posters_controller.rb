class PostersController < ApplicationController
    before_action :require_login, :except => [:new, :create]
    before_action :require_admin, :only => [:destroy]

    def new
    end
    
    def create
        @num = Poster.all.count
        if(@num < Event.find(1).max_poster_number)
            @poster = Poster.create(params[:poster].merge({:number => Poster.count + 1}).permit(:number, :presenter, :title, :advisors, :email))
            if @poster.errors.messages.empty?
                flash[:notice] = "#{@poster.title} was successfully created."
                
                # Send Confirmation email when the admin or the student uploads an individual poster
                RemindMailer.confirmation_email(@poster).deliver_later
                
                if admin?
                    redirect_to admin_posters_path
                else
                    redirect_to root_path
                end
                return
            else
                flash[:error] = "Please correct the following fields: #{@poster.errors.messages.keys.join(', ')}"
                render :action => 'new' #and now the css breaks :(
            end
        else
            flash[:error] = "Poster could not be created- poster limit reached"
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
#        rescue ActiveRecord::RecordNotFound    #situation in which this occurs: poster delete between clicking edit and update
#            flash[:notice] = "No such poster"
#            redirect_to admin_posters_path and return
        @poster.update_attributes(params[:poster].permit(:number, :presenter, :title, :advisors, :email))
        if @poster.errors.messages.empty?
            flash[:notice] = "#{@poster.title} was successfully updated."
            redirect_to admin_posters_path and return
        else
            flash[:error] = "Please correct the following fields: #{@poster.errors.messages.keys.join(', ')}"
            render :action => 'edit'
        end
    end
    
    def destroy
        @poster = Poster.find(params[:id])
        @poster.destroy
        Poster.where("number > ?", @poster.number).update_all("number = number - 1")
        flash[:notice] = "Poster deleted."
        redirect_to admin_posters_path
    end

end
