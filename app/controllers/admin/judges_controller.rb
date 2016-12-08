require 'securerandom'

class Admin::JudgesController < ApplicationController
    before_action :require_login, :require_admin

    def index
        if current_user.role == "superadmin"
            @judges = Judge.all
        else
            @judges = Judge.where("role = ? or id", "judge", current_user.id)
        end
    end

    def create
        admin_num = params[:admin_number].to_i
        make_user(admin_num, 'admin')
        
        num = params[:number].to_i
        make_user(num, 'judge')
        
        redirect_to admin_judges_path
    end

    def make_user(num, role)
        i = 0
        while i < num
            code = SecureRandom.hex(2)
            if(Judge.where(access_code: code).size == 0)
                judge = Judge.new('access_code' => code, 'role' => role)
                judge.save!(validate: false)
                i = i + 1
            end
        end
    end

    def clear
        Judge.where(role: "judge").destroy_all
        @judges = Judge.all
        redirect_to admin_judges_path
    end
    
    def destroy
        Judge.destroy(params[:id])
        @judges = Judge.all
        redirect_to admin_judges_path
    end
end
