module  ScoresHelper
    def show_score(score)
        t = score.to_s.match(/^(\d+(\.\d+)?)$/)
        if  t
        	(score.class ==  Float) ? ("%.3f" % score) : score
        elsif score == "no_show"
            "No Show"
        else
        	'-'
        end
    end
=begin    
    def show_avg(no_show, avg)
        if no_show
            "No Show"
        else
            show_score(avg)
        end
    end
=end
    def show_poster_avg(poster, avg)
        if poster.scores.empty?
            no_show = false
        else
            no_show = true
            poster.scores.each do |score|
                no_show = false unless score.no_show
            end
        end
        show_avg(no_show, avg)
    end
    
    def show_avg(no_show, avg)
        if no_show
           "No Show" 
        else
            show_score(avg)
        end
    end
    
    def filter(state)
       return @filter.eql?(state)
    end

    def no_show_msg
        msg = "Are you sure?"
        unless @no_show || admin?
            msg = "This poster is scored by other judges, are you sure?"
        end
        return msg
    end
  # method separated from /app/views/admin/scores/index.html.haml
  # used to count # of times a poster is scored = # of scoring judges
  def get_actual_scores_count(poster)
      return (poster.scores_count - poster.scores.where("#{Score.score_terms[0]} = -1").count)
  end
  
  def view_ranking(viewed_poster_avg, i)
      @temp_poster_avg ||= 0.0
      if viewed_poster_avg != @temp_poster_avg
          @temp_poster_avg = viewed_poster_avg
          return i + 1
      else
          return i
      end

  end
end