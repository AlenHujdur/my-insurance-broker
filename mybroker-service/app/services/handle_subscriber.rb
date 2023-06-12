class HandleSubscriber
  def initialize(requested_quote_params, subscriber_params)
    @requested_quote_params = requested_quote_params #.nil? ? {} : requested_quote_params
    @subscriber_params = subscriber_params #.nil? ? {} : subscriber_params
  end

  def create
    @subscriber = find_or_create_subscriber
    if !requested_quote_params.nil?
      requested_quote = RequestedQuote.new(requested_quote_params)
      requested_quote.subscriber = @subscriber
      requested_quote.subscriber_id = @subscriber.id # Assign subscriber_id to requested_quote
      if requested_quote.save!
        { success: true, message: 'Requested quote created successfully!' }
      else
        { success: false, error: 'Failed to create requested quote' }
      end
    end
    @subscriber
  end

  private

  def find_or_create_subscriber
    @subscriber = Subscriber.find_by(email: subscriber_params[:email])

    if !@subscriber.nil?
      if @subscriber.name.nil?
        @subscriber.name = subscriber_params[:name]
      end
      if @subscriber.phone.nil?
        @subscriber.phone = subscriber_params[:phone]
      end
      if @subscriber.message.nil?
        @subscriber.message = subscriber_params[:message]
      end
      if @subscriber.save!
        return  @subscriber if @subscriber && SubscriberMailer.send_notification(@subscriber).deliver_now
      end
    end
    @subscriber = Subscriber.new(subscriber_params)
    return @subscriber if @subscriber.save! && SubscriberMailer.send_notification(@subscriber).deliver_now
  end

  private
  def requested_quote_params
    @requested_quote_params
  end

  def subscriber_params
    @subscriber_params
  end
end
