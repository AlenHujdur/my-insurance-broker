class Api::V1::RequestedQuotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    service = HandleSubscriber.new(requested_quote_params, subscriber_params)
    result = service.create

    generate_quote = QuoteGenerator.new(requested_quote_params, subscriber_params)
    quote = generate_quote.generate

    if result[:success] && quote[:success]
      render json: { message: result[:message] }, status: :created
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end

  def update
    requested_quote = RequestedQuote.find(params[:id])

    if requested_quote.update(requested_quote_params)
      render json: { message: 'Requested quote updated!' }, status: :ok
    else
      render json: { error: 'Failed to update' }, status: :unprocessable_entity
    end
  end

  private

  def requested_quote_params
    params.permit(:subscriber, :business_type, :industry, :policy_limit, :deductible, :coverage_period)
  end

  def subscriber_params
    params.require(:subscriber).permit(:email, :name, :phone)
  end

end
