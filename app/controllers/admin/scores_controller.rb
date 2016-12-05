# in /app/controllers/admin/scores_controller.rb
require 'csv'

class Admin::ScoresController < ApplicationController
  before_filter :require_login, :require_admin
  def is_i?(str)
    !str.match(/^[-+]?[0-9]+$/).nil?
  end
  
  def avgs_init
    @judge_avgs = Hash.new
    @poster_avg = 0
    @term_avgs = Hash.new()
    @score_terms.each do |term|
      @term_avgs[term] = 0
    end
  end
  
  def avgs_final(count)
    if count > 0
        @poster_avg /= count.to_f
        @term_avgs = @term_avgs.map {|k,v| k,v = k,v/count.to_f}.to_h
    else
        @term_avgs = @term_avgs.map {|k,v| k,v = k, -1}.to_h
        @poster_avg = -1
    end
  end
  
  def cal_poster_avg
    avgs_init
    count = 0
    @scores.each do |score|
      score_sum = Score.get_score_sum().find(score.id).score_sum
      if score_sum > 0
        @judge_avgs[score.judge_id] = score_sum/@score_terms.size.to_f
        @poster_avg += @judge_avgs[score.judge_id]
        count += 1
        @score_terms.each do |term|
          @term_avgs[term] += score[term]
        end
      end
    end
    
    avgs_final(count)
    return count
  end

  def get_poster_avg(poster)
    @scores = poster.scores.sort_by {|score| score.judge.name}
    @poster_avg = -1
    
    if poster.scores_count > 0
      cal_poster_avg
    end
    
    return @poster_avg
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

  def select_posters_by_filter(origin_posters, posters, filter)
    origin_posters.each do |poster|
       #assume the poster is unscored at first, then we will find out whether it is scored or not
      type = "completed"
      poster.scores.each do |score|
        if score.no_show
          posters << poster if filter == "no_show"
          type = "no_show"
          break
        elsif score.send(Score.score_terms[0]) < 0
          posters << poster if filter == "inprogress"
          puts "Inprogress!!!!!!!!!!!" 
          type = "inprogress"
          break
        end
      end
      posters << poster if filter == "completed" && type == "completed"
    end
    return posters
  end

	def select_posters(origin_posters, filter)
	  inprogress_posters = origin_posters.select {|p| p.scores_count == 3 }
	  undone_posters = origin_posters - inprogress_posters
	  
	  if filter == "undone"
	    return undone_posters
	  end
	  
	  posters = []
	  
	  if filter == "no_show"
	    undone_posters.each do |poster|
        poster.scores.each do |score|
          posters << poster if score.no_show
          break
        end
      end
	  end
	  #among assigned posters, there are three type: inprogress, no_show, completed
	  # we now label each poster with its write type
    select_posters_by_filter(inprogress_posters, posters, filter)
    return posters
	end

def filter_posters(status)
    if status
        session[:status] = status
    end
    if session[:status] && session[:status] != "all"
      @posters = select_posters(@posters, session[:status])
    end
    @filter = session[:status] || ""
end

  def index
    @score_terms = Score.score_terms
    @posters = get_posters_by_keywords(params[:searchquery])
    @poster_avgs = Hash.new
    filter_posters( params[:status])
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
  
  def rankings
        @score_terms = Score.score_terms
        @posters = Poster.all_scored
        @poster_avgs = Hash.new
        @posters.each do |poster|
          poster_avg = get_poster_avg(poster)
          if poster_avg < 0
            @posters = @posters.reject {|p| p.id == poster.id}
          else
            @poster_avgs[poster.id] = poster_avg
          end
        end
        @posters = @posters.sort_by{|poster| @poster_avgs[poster.id]}.reverse
        @posters = @posters.take(3)
        
        create_rank_file(@posters, @poster_avgs)  #FIXME this should be run before a download, right?
  end

  def create_rank_file(posters, scores)
        File.delete("downloads/rankings.csv") if File.exists?("downloads/rankings.csv")
        CSV.open("downloads/rankings.csv", "wb") do |csv|
            csv << ["rank", "presenter", "title", "score"]
            rank = 1
            for poster in posters
                csv << [rank, poster.presenter, poster.title, scores[poster.id]]
                rank += 1
            end
        end
  end
  def download_ranks
    
        send_file("downloads/rankings.csv", :filename => "rankings.csv")
  end
  
  def download_scores
        File.delete("app/downloads/scores.csv") if File.exists?("app/downloads/scores.csv")
        @scores = Score.all
        vals = @scores.attribute_names
        
        CSV.open("app/downloads/scores.csv", "wb") do |csv|
            csv << vals + [:judge_name, :judge_company_name, :poster_title, :poster_presenter, :poster_number] 
            for score in @scores
            poster = Poster.find(score.poster_id)
            judge = Judge.find(score.judge_id)
            	csv << vals.map{ |v| score.send(v) } + [judge.name, judge.company_name, poster.title, poster.presenter, poster.number]
            end
        end
        send_file("app/downloads/scores.csv")
  end

end
