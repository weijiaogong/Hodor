class JudgesController < ApplicationController
    before_action :require_login, :require_correct_user
=begin
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
            first = Score.find(score.id).send(Score.score_terms[0])
            if  score.no_show || first >= 0
                @disable += [score.poster_id]
            end
        end
    end
=end
  def get_judge_avgs
    @judge_avgs = Hash.new
    @judge.scores.each do |score|
        if score.no_show
            @judge_avgs[score.poster_id] = "no_show"
        else
            score_sum = Score.get_score_sum().find(score.id).score_sum
            @judge_avgs[score.poster_id] = score_sum/@score_terms.size.to_f
        end
    end
  end
    #display the posters assigned to a specific judge
    def show
        @score_terms = Score.score_terms
        @judge = Judge.find(params[:id])
        @posters = @judge.posters.order(:number)
        #set_disable() #judge can edit their score later
        get_judge_avgs
        
        #orphan posters
        @orphan_poster = get_another_posters(1).first
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
        posters = assign_posters(3)
        if posters.empty?
            flash[:notice] = "There are no more posters to be assigned."
        end
        redirect_to judge_path(@judge)
    end
    
    def get_another_posters(n)
        posters = Poster.find_least_judged()
        unless posters.empty?
            posters = posters.reject {|p| @judge.posters.include?(p)}
            posters = posters.sample(n)
        end
        return posters
    end
    
    def assign_posters(n)
         #create 2 - 3 new Scores for each poster assigned to this judge
        posters = get_another_posters(n)
        posters.each do |poster|
            Score.assign_poster_to_judge(poster, @judge)
        end
        return posters
    end

    #display the form to add name and company name for a specific judge
    def register
        @judge = Judge.find(params[:judge_id])
    end
    def release_unscored_posters(judge)
        judge.scores.each do |score|
            #sum = Score.get_score_sum.find(score.id).score_sum
            first_score = score.send(Score.score_terms[0])
            next if first_score > 0
            #no show should not be deleted for later
            Score.destroy(score.id) unless score.no_show
        end
    end
     # reasign all unscored posters to other available judgers
    def leave
        @judge = Judge.find(params[:judge_id])
        begin
            #@judge.update_attributes!(:leave => true)
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