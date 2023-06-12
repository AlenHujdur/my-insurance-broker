class QuoteMailer < ApplicationMailer
  def send_quote(subscriber, quote, attachment = nil)

    @subscriber = subscriber
    @quote = quote
    if !attachment.nil?
      attachments['quote.pdf'] = attachment
    end
    mail(to: @subscriber[:email], subject: "Thanks for subscribing!") do |format|
      format.html { render layout: 'mailer' }
    end
  end
end
