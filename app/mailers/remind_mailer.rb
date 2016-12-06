class RemindMailer < ApplicationMailer
    
    
    def remind_email(poster)
            @poster = poster
    		mail(to: poster.email , subject: 'Reminder about the IAP Poster Competition')
    end
    
    def confirmation_email(poster)
            @poster = poster
    		mail(to: poster["email"] , subject: 'Confirmation of Regisration for IAP Poster Competition')
    end
    
    def self.call_remind_email
       Poster.find_each do |poster|
            remind_email(poster).deliver_now
    	end
    end
  
  
end
