# in /app/controllers/admin/scores_controller.rb
require 'csv'

class Admin::ScoresController < ApplicationController
  before_filter :require_login, :require_admin
  
  def get_poster_avg(poster)
    @scores = poster.scores
    @poster_avg = -1
    @term_avgs = Hash.new()
    @score_terms.each do |term|
      @term_avgs[term] = -1
    end
    if poster.scores_count > 0
      @judge_avgs = Hash.new
      @poster_avg = 0
      @term_avgs = @term_avgs.map {|k,v| k,v = k, 0}.to_h
      count = 0
      @scores.each do |score|
        score_sum = Score.get_score_sum().find(score.id).score_sum
        @temp_score = [score_sum, score.id]
        if score_sum > 0
          @judge_avgs[score.judge_id] = score_sum/@score_terms.size.to_f
          @poster_avg += @judge_avgs[score.judge_id]
          count += 1
          @score_terms.each do |term|
            @term_avgs[term] += score[term]
          end
        end
      end
      if count > 0
        @poster_avg /= count.to_f
        @term_avgs = @term_avgs.map {|k,v| k,v = k,v/count.to_f}.to_h
      else
        @term_avgs = @term_avgs.map {|k,v| k,v = k, -1}.to_h
        @poster_avg = -1
      end
    end
    
    @scores =  @scores.sort_by {|score| score.judge.name}
    return @poster_avg
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
    @poster_avgs = Hash.new
    filter(params[:status])
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
    render 'scores/edit'
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

  def assign
     
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
