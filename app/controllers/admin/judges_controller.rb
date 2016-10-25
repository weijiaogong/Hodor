require 'securerandom'

class Admin::JudgesController < ApplicationController
    before_filter :require_login, :require_admin

    def index
        @judges = Judge.find(:all)
    end

    def create
        num = params[:number].to_i
        i = 0
        while i < num
            code = SecureRandom.hex(2)
            if(Judge.where(access_code: code).size == 0)
                Judge.create!('access_code' => code, 'role' => 'judge')            
                i = i + 1
            end
        end
        redirect_to admin_judges_path
    end

    def clear
        Judge.where('id != 1').destroy_all  #TODO destroy all but admin/superadmin?
        redirect_to admin_judges_path
    end
end
