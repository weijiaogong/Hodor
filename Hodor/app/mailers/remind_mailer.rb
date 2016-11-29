class RemindMailer < ApplicationMailer
    
    
    def remind_email(poster)
       #Poster.find_each do |papa|
            @poster = poster
    		mail(to: poster.email , subject: 'Reminder about the IAP Poster Competition')
    	 #end
    end
    
    def self.call_remind_email
       Poster.find_each do |poster|
            remind_email(poster).deliver_now
    	end
    end
  
  
end
