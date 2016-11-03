class Admin::ScoresController < ApplicationController
  before_filter :require_login, :require_admin
  def avg_per_judge(scores)
      avgs_per_judge = Hash.new
      scores.each do |score|
         avgs_per_judge[score.judge_id] = (score.novelty + score.utility + score.difficulty + score.verbal + score.written)/5.0
      end
      return avgs_per_judge
  end

  def sum_judge_avg(avgs_per_judge)
      sum_judge_avg = 0
      avgs_per_judge.each do |judge, avg|
         if avg > 0
           sum_judge_avg += avg
         end
      end
      return sum_judge_avg
  end

  def avg_per_poster(poster)
    if poster.scores_count > 0
      @scores = poster.scores
      @avgs_per_judge = avg_per_judge(@scores)
      @avg_per_poster = sum_judge_avg(@avgs_per_judge)
      @avg_per_poster /= poster.scores_count.to_f
    else
      @avg_per_poster = -1
    end
  end

  def index
    @score_terms = Score.score_terms
    keywords = params[:searchquery] || ""
    keywords = keywords.gsub(/[^a-z0-9\s]/i, " ")
    if keywords.empty? || keywords.match(/^\s+$/)
      @posters = Poster.all
    else
      @posters = Poster.find_by_keywords(keywords)
    end
		
    @avgs = Hash.new
    @posters.each do |poster|
		   @avgs[poster.id] = avg_per_poster(poster)
    end
  end

  def show
    @score_terms = Score.score_terms
    poster_id = params[:id]
    @poster = Poster.find(poster_id)
    avg_per_poster(@poster)
  end

  def edit
    score   = Score.find(params[:id])
    @poster = score.poster
    @judge  = score.judge
    render 'posters/edit'
  end

  def score_params(score_id)
  	@score_terms = Score.score_terms
    score_params = Hash.new
    @score_terms.each do |term|
       score_params[term.to_sym] = params[term]
    end
    return score_params
  end
  
  def update
      score_id = params[:id]
      @score = Score.find(score_id)

      begin
        @score.update_attributes!(params.require("score"))
        flash[:notice] = "The scores given by #{@score.judge.name} were updated successfully."
        @score.poster.update_attributes!(:scores_count => @score.poster.scores_count + 1)
        redirect_to admin_score_path(@score.poster)
      rescue ActiveRecord::RecordInvalid => invalid
          flash[:notice] = invalid
          redirect_to judge_poster_judge_path(judge_id, poster_id)
      end
  end


  def rankings
        @posters = Poster.all
        @avg_scores = Hash.new
        @posters.each do |poster|
          poster_avg = avg_per_poster(poster)
          if poster_avg > 0
             @avg_scores[poster.id] = poster_avg
          else
             @posters.delete(poster)
          end
        end
     
        @posters = @posters.sort_by{|poster| @avg_scores[poster.id]}.reverse
        @posters = @posters.take(3)

        create_rank_file(@posters, @avg_scores)
  end

  def create_rank_file(posters, scores)
        File.delete("app/downloads/rankings.csv") if File.exists?("app/downloads/rankings.csv")
        CSV.open("app/downloads/rankings.csv", "wb") do |csv|
            csv << ["rank", "presenter", "title", "score"]
            rank = 1
            for poster in posters
                csv << [rank, poster.presenter, poster.title, scores[poster.id]]
                rank += 1
            end
        end
  end
  def download_ranks
        send_file("app/downloads/rankings.csv", :filename => "rankings.csv")
  end

end
