class JudgesController < ApplicationController
    before_filter :require_login, :require_correct_user

    #display the posters assigned to a specific judge
    def show
        @judge = Judge.find(params[:id])
        @posters = @judge.posters.find(:all, :order => "number")
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
            redirect_to judge_register_path and return
        end
        
        @judge.update_attributes(name: params[:name], company_name: params[:company])
        
        @posters = Poster.find_least_judged()
        
        if(@posters.count == 0)
            flash[:error] = "There are no more posters to be assigned."
            render "/error" and return
        end
        
        @posters.each do |poster| 
            Judge.assign_poster(poster.id, @judge.id)
        end
        
        sign_in @judge
        redirect_to judge_path(@judge.id)
    end

    #display the form to add name and company name for a specific judge
    def register
        @judge = Judge.find(params[:judge_id])
    end
end
