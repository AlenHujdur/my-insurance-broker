class Api::V1::RequestedQuotesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    service = HandleSubscriber.new(requested_quote_params, subscriber_params)
    result = service.create

    generate_quote = QuoteGenerator.new(requested_quote_params, subscriber_params)

    quote = generate_quote.generate
    if !result.nil? && quote[:success]
      render json: { quote: quote }, status: :created
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
    params.require(:requested_quote).permit(:natural_person, :enterprise_number, :legal_name, :annual_revenue, nacebel_codes: [])
  end

  def subscriber_params
    params.require(:subscriber).permit(:email, :name, :phone)
  end

end
