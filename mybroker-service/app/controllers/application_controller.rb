class ApplicationController < ActionController::Base
  def authenticity_token
    render json: { token: form_authenticity_token }
  end
end
