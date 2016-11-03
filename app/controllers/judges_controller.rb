class JudgesController < ApplicationController
    before_filter :require_login, :require_correct_user

    #display the posters assigned to a specific judge
    def show
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
        
        @posters = @judge.posters.order(:number)
        #@posters.sort! {|p| p.number.to_i}.reverse!
        no_notice = true 
        if flash[:notice]
            no_notice = false
        end
        num = 3 - @posters.size
        if num >= 1
           res = assign(num)
           if res == 0 && no_notice
               flash[:notice] = nil
           end
        end
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
        redirect_to judge_path(@judge)
    end
    #create 2 - 3 new Scores for each poster assigned to this judge
    def assign(n)
        #create 2 - 3 new Scores for each poster assigned to this judge
        posters = Poster.find_least_judged()
        if posters.empty?
            flash[:notice] = "There are no more posters to be assigned."
            return 0
        end
        
        i = 0
        posters.each do |poster|
            unless @judge.posters.include?(poster)
               Score.assign_poster_to_judge(poster, @judge)
               i += 1
               if i == n
                   break
               end
            end
        end
        return i
    end
    #display the form to add name and company name for a specific judge
    def register
        @judge = Judge.find(params[:judge_id])
    end
    def release_unscored_posters(judge)
        score_terms = Score.score_terms
        judge.scores.each do |score|
            sum = 0
            score_terms.each do |term|
                sum += score.send(term)
            end

            next if sum >= 5

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
