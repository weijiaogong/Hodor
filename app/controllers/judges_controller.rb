class JudgesController < ApplicationController
    before_filter :require_login, :require_correct_user

    def comeback_assign()
        no_notice = flash[:notice]? false : true
        num = 3 - @judge.scores_count
        if num >= 1
           res = assign(num)
           if res == 0 && no_notice
               flash[:notice] = nil
           end
        end
    end
    
    def set_disable()
        @disable = Array.new
	
        for score in @judge.scores
            sum = Score.get_score_sum.find(score.id).score_sum
            if  score.poster.no_show || sum >= 5
                @disable += [score.poster_id]
            end
        end
    end
    
    #display the posters assigned to a specific judge
    def show
        @score_terms = Score.score_terms
        @judge = Judge.find(params[:id])
        if @judge.leave
            begin
               @judge.update_attributes!(leave: false)
               sign_in @judge # this is important: resign in after udpation, I do not know why
            rescue ActiveRecord::RecordInvalid => invalid
              flash[:error] = invalid
              redirect_to root_url and return
            end
        end
        comeback_assign()
        @posters = @judge.posters.order(:number)
        set_disable()
        
         #unscored posters
        @orphan_posters = Poster.find_least_judged()
        @orphan_posters = @orphan_posters.reject {|p| @posters.include?(p)}
    end    

    #update judge information (name, company name)
    def update
        @judge = Judge.find(params[:id])
        res = @judge.update_attributes(name: params[:name], company_name: params[:company])
        # this validation should be down in js
        unless res
          flash[:error] = "name & company_name cannot be blank"
          redirect_to judge_register_path(@judge) and return
        end
        sign_in @judge
        assign(3)
        redirect_to judge_path(@judge)
    end
    #create 2 - 3 new Scores for each poster assigned to this judge
    def assign(n)
        #create 2 - 3 new Scores for each poster assigned to this judge
        posters = Poster.find_least_judged()
        if posters.empty?
            flash[:notice] = "There are no more posters to be assigned."
            puts flash[:notice]
            return 0
        end
        posters = posters.reject {|p| @judge.posters.include?(p)}
        posters = posters.sample(n)
        posters.each do |poster|
            Score.assign_poster_to_judge(poster, @judge)
        end
        return posters.size
    end
    #display the form to add name and company name for a specific judge
    def register
        @judge = Judge.find(params[:judge_id])
    end
    def release_unscored_posters(judge)
        judge.scores.each do |score|
            #sum = Score.get_score_sum.find(score.id).score_sum
            first = Score.find(score.id)[0]
            next if first >= 0
            #no show should not be deleted for later
            Score.destroy(score.id)
        end
    end
     # reasign all unscored posters to other available judgers
    def leave
        @judge = Judge.find(params[:judge_id])
        begin
            @judge.update_attributes!(:leave => true)
            release_unscored_posters(@judge)
            flash[:notice] = "You have successfully signed out!"
            sign_out
            redirect_to root_url
        rescue ActiveRecord::RecordInvalid => invalid
          flash[:error] = invalid
          redirect_to judge_path(judge_id)
        end
    end
end
