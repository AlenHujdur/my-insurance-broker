class HandleSubscriber
  def initialize(requested_quote_params, subscriber_params)
    @requested_quote_params = requested_quote_params
    @subscriber_params = subscriber_params
  end

  def create
    subscriber = find_or_create_subscriber

    requested_quote = RequestedQuote.new(requested_quote_params)
    requested_quote.subscriber = subscriber
    requested_quote.subscriber_id = subscriber.id # Assign subscriber_id to requested_quote

    if requested_quote.save
      { success: true, message: 'Requested quote created successfully!' }
    else
      { success: false, error: 'Failed to create requested quote' }
    end
  end

  private

  def find_or_create_subscriber
    @subscriber = Subscriber.find_by(email: subscriber_params[:email])
    return  @subscriber if @subscriber && SubscriberMailer.send_notification(@subscriber).deliver_now

    @subscriber = Subscriber.new(subscriber_params)
    return @subscriber if @subscriber.save! && SubscriberMailer.send_notification(@subscriber).deliver_now
  end

  def requested_quote_params
    @requested_quote_params
  end

  def subscriber_params
    @subscriber_params
  end
end
