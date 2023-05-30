class SubscriberMailer < ApplicationMailer
  def send_notification(subscriber)
    @subscriber = subscriber

    mail(to: @subscriber.email, subject: "Thanks for subscribing!") do |format|
      format.html { render layout: 'mailer' }
    end
  end
end
