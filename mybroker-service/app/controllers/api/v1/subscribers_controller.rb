class Api::V1::SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_forgery_protection with: :null_session, only: [:create]
  def create
    service = HandleSubscriber.new(nil, subscriber_params)
    @subscriber = service.create

    if @subscriber[:success]
      SubscriberMailer.send_notification(@subscriber).deliver_now
      render json: { message: 'Subscribed successfully!' }, status: :created
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
