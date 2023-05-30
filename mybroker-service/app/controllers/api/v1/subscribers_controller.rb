class Api::V1::SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      SubscriberMailer.send_notification(@subscriber).deliver_now
      render json: { message: 'Subscribed successfully!' }, status: :created
    else
      render json: { error: 'Failed to subscribe' }, status: :unprocessable_entity
    end
  end

  def update
    subscriber = Subscriber.find(params[:id])

    if subscriber.update(subscriber_params)
      render json: { message: 'Subscriber updated!' }, status: :ok
    else
      render json: { error: 'Failed to update' }, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email, :name, :phone, :message)
  end
end
