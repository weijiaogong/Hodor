class RemindMailer < ApplicationMailer
    
    
    def remind_email(presenter)
         mail(to: presenter.email , subject: 'Reminder about the IAP Poster Competition')
    end
  
  
end
