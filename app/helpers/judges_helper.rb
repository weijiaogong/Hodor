module  JudgesHelper

    def get_rank(role)
        case role
        when 'superadmin'
             2
        when 'admin'
             1
        when 'judge'
        	 0
        else
        	-1
        end
    end
    def higher_rank?(role)
        if  get_rank(role) >= get_rank(current_user.role)
           return true
        else
           return false
        end
    end
 
    def accept_poster_msg
        if @orphan_poster
            return "Do you want to judge poster ##{@orphan_poster.id} " + @orphan_poster.title + " ?"
        else
            return "All posters have been judged"
        end
    end

   
end