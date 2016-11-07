require 'csv'

class Admin::ScoresController < ApplicationController
  before_filter :require_login, :require_admin

  def avg_per_score(id)
      avg_per_score = Score.get_score_sum().find(id).score_sum
      avg_per_score /= @score_terms.size.to_f 
      return  avg_per_score
  end
  
  def avgs_by_judge(scores)
      judge_avgs = Hash.new
      scores.each do |score|
        judge_avgs[score.judge_id] = avg_per_score(score.id)
      end
      return judge_avgs
  end
  def avg_per_poster(poster)
        poster_sum = Score.get_poster_sum.find_by(poster_id: poster.id).poster_sum
        puts poster_sum.to_s
        poster_avg = poster_sum/poster.judges.size.to_f
        poster_avg /= @score_terms.size.to_f
        return poster_avg
  end
  def get_poster_avg(poster)
    @scores = poster.scores
    if poster.scores_count > 0
      @scores =  @scores.sort_by {|score| score.judge.name}
      @judge_avgs = avgs_by_judge(@scores)
      @poster_avg = avg_per_poster(poster)
    else
      @poster_avg = -1
    end
  end

  def is_i?(str)
    !str.match(/^[-+]?[0-9]+$/).nil?
  end
  
  def get_posters_by_keywords(keywords)
      keywords =  keywords || ""
      keywords = keywords.gsub(/[^a-z0-9\s]/i, " ")
      posters = []
      if keywords.empty? || keywords.match(/^\s+$/)
        posters = Poster.all.order(:number)
      elsif is_i?(keywords)
        posters = Poster.where(number: keywords.to_i)
      else
        posters = Poster.find_by_keywords(keywords).order(:number)
      end
      return posters
  end
=begin
  #for checkbox
  def filter(status)
    if status
        session[:status] = status.keys.join("")
    end
    case session[:status]
      when "no_show"
        @posters = @posters.select {|p| p.no_show }
      when "scored"
        @posters = @posters.select {|p| p.scores_count > 0}
      when "unscored"
        @posters = @posters.select {|p| p.no_show == false and p.scores_count == 0}
    end
    @filter = session[:status] || ""
  end
=end 
def filter(status)
    if status
        session[:status] = status
    end
    case session[:status]
      when "no_show"
        @posters = @posters.select {|p| p.no_show }
      when "scored"
        @posters = @posters.select {|p| p.scores_count > 0}
      when "unscored"
        @posters = @posters.select {|p| p.no_show == false and p.scores_count == 0}
    end
    @filter = session[:status] || ""
end

  def index
    @score_terms = Score.score_terms
    @posters = get_posters_by_keywords(params[:searchquery])
    filter(params[:status])
    @poster_avgs = Hash.new
    # calcualte average score for each poster
    @posters.each do |poster|
		   @poster_avgs[poster.id] = get_poster_avg(poster)
    end
  end

  def show
    @score_terms = Score.score_terms
    poster_id = params[:id]
    @poster = Poster.find(poster_id)
    get_poster_avg(@poster)
  end

  def edit
    score   = Score.find(params[:id])
    @poster = score.poster
    @judge  = score.judge
    render 'posters/judge'
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
        @score_terms = Score.score_terms
        @posters = Poster.all_scored
        @poster_avgs = Hash.new
        @posters.each do |poster|
          poster_avg = get_poster_avg(poster)
          @poster_avgs[poster.id] = poster_avg
        end
        @posters = @posters.sort_by{|poster| @poster_avgs[poster.id]}.reverse
        @posters = @posters.take(3)

        create_rank_file(@posters, @poster_avgs)
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
