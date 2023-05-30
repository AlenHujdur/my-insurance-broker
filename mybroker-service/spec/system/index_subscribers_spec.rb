require "rails_helper"

RSpec.describe "IndexSubscribers", type: :system do
  before { driven_by(:rack_test) }

  scenario "Loads successfully" do
    visit subscribers_path
    expect(page).to have_http_status(:success)
  end
end
