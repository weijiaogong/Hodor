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
    
    def volunteer_msg
        msg = @notice ? @notice : "Are you sure?"
        return msg
    end
    
end