class SendEmailJob < ApplicationJob
  queue_as :default

  def perform#(*args)
    # Do something later
		RemindMailer.remind_email.deliver_now

  end
end
