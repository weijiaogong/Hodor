class JudgesController < ApplicationController
    before_filter :require_login, only: [:show]

    def require_login
      unless current_user == Judge.find(params[:id])
        flash[:error] = "You must be logged in to access this action"
        redirect_to signin_path
      end
    end

    #display the posters assigned to a specific judge
    def show
        @judge = Judge.find(params[:id])
        @posters = @judge.posters.find(:all)
    end    
    
    #update judge information (name, company name)
    #create 2 - 3 new Scores for each poster assigned to this judge
    def assign
        @judge = Judge.find(params[:judge_id])
        error_msg = "Missing: "
	    if(params[:name].empty?)
            error_msg += "name"	    
        end

        if(params[:company].empty?)
            if error_msg != "Missing: "
                error_msg += ", "
            end
            error_msg += "company"
        end
        if error_msg != "Missing: "
            flash[:error] = error_msg
            @judge.destroy
            redirect_to register_judges_path and return
        end
        
        @judge.update_attributes(name: params[:name], company_name: params[:company])
        
        @posters = Poster.find_least_judged().first(3)
        
        if(@posters.count == 0)
            flash[:error] = "There are no more posters to be assigned."
            @judge.destroy
            render "/error" and return
        end
        
        @posters.each do |poster| 
            Judge.assign_poster(poster.id, @judge.id)
        end
        
        redirect_to judge_path(params[:judge_id])
    end

    #display the form to add name and company name for a specific judge
    def register
        @judge = Judge.create! #temporary
    end
end
