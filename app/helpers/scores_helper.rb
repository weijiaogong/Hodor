module  ScoresHelper
    def show_score(score)
        t = score.to_s.match(/^(\d+(\.\d+)?)$/)
        if  t
        	(score.class ==  Float) ? ("%.3f" % score) : score
        else
        	'-'
        end
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
        msg = "are you sure?"
        unless @no_show
            msg = "This poster is scored by other judges, please contact administrator for help"
        end
        return msg
    end

  # separate method from index
  # used to count # of times a poster is scored = # of scoring judges
  def get_actual_scores_count(poster)
      return (poster.scores_count - poster.scores.where("#{Score.score_terms[0]} = -1").count)
  end

end