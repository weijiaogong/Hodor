require 'securerandom'

class Admin::JudgesController < ApplicationController
    before_filter :require_login, :require_admin

    def index
        @judges = Judge.all
    end

    def create
        num = params[:number].to_i
        i = 0
        while i < num
            code = SecureRandom.hex(2)
            if(Judge.where(access_code: code).size == 0)
                judge = Judge.new('access_code' => code, 'role' => 'judge')   
                judge.save!(validate: false)
                i = i + 1
            end
        end
        redirect_to admin_judges_path
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
