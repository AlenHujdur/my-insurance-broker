require 'rails_helper'

RSpec.describe "Subscribers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/subscribers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
