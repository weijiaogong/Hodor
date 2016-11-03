module  JudgesHelper

    def get_rank(role)
        case role.downcase
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
        if get_rank(current_user.role)> get_rank(role)
           false
        else
           true
        end

    end

end