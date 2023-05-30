class QuoteMailer < ApplicationMailer
  def send_quote(subscriber, quote)
    @subscriber = subscriber
    @quote = quote

    mail(to: @subscriber[:email], subject: "Thanks for subscribing!") do |format|
      format.html { render layout: 'mailer' }
    end
  end
end
