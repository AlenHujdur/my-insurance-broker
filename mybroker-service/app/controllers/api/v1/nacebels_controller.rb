class Api::V1::NacebelsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_forgery_protection with: :null_session, only: [:create]
  def index
    @nacebels = Nacebel.show_only_level5_for_medicine
    if params[:download]
      send_data @nacebels.to_json, filename: "nacebels.json", type: "application/json"
    else
      render json: @nacebels
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email, :name, :phone, :message)
  end
end
