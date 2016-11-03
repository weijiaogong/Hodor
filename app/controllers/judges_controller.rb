class JudgesController < ApplicationController
    before_filter :require_login, :require_correct_user

    #display the posters assigned to a specific judge
    def show
        @judge = Judge.find(params[:id])
        @posters = @judge.posters.order(:number)
        #@posters.sort! {|p| p.number.to_i}.reverse!
        @disable = Array.new
	
        for score in @judge.scores
            sum = (score.novelty + score.utility + score.difficulty + score.verbal + score.written)
            if score.no_show == true || sum >= 5
                @disable += [score.poster_id]
            end
        end
    end    

    #update judge information (name, company name)
    def update
        @judge = Judge.find(params[:id])
        res = @judge.update_attributes(name: params[:name], company_name: params[:company])
        unless res
          flash[:error] = "name & company_name cannot be blank"
          redirect_to judge_register_path(@judge) and return
        end
        sign_in @judge
        assign(3)
    end
    
    #create 2 - 3 new Scores for each poster assigned to this judge
    def assign(n)
        #create 2 - 3 new Scores for each poster assigned to this judge
        posters = Poster.find_least_judged().sample(n)
        if posters.empty?
            flash[:notice] = "There are no more posters to be assigned."
            redirect_to judge_path(@judge) and return
        end
        
        posters.each do |poster| 
            Score.assign_poster_to_judge(poster, @judge)
        end
        redirect_to judge_path(@judge) and return
    end
    #display the form to add name and company name for a specific judge
    def register
        @judge = Judge.find(params[:judge_id])
    end
    
end
