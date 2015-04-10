class PostersController < ApplicationController
    
    #render the view for judging each poster
    def edit
        @poster = Poster.find(params{:id})
        @judge = Judge.find(params{:judge_id})
    end    
    
    #update the Score associated with a specific poster and a specific judge
    def update
        #check to make sure all radio buttons are checked

        @score = Score.where(judge_id: @judge.id, poster_id: @poster.id).first()
        
        @score.update_attributes(:novelty => params{:cat1}.to_i, :utility => params{:cat2}.to_i, :difficulty => params{:cat3}.to_i, :verbal => params{:cat4}.to_i, :written => params{:cat5}.to_i, :no_show => false)

    end

    def no_show
        @score = Score.where(judge_id: @judge.id, poster_id: @poster.id).first()

        @score.no_show = true
        @score.novelty = -1
        @score.utility = -1
        @score.difficulty = -1
        @score.verbal = -1
        @score.written = -1
    end
end
