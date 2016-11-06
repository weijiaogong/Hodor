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
end