require "rails_helper"

RSpec.describe "NewSubscriber", type: :system do
  before { driven_by(:rack_test) }

  scenario "Loads successfully" do
    visit new_subscriber_path
    expect(page).to have_http_status(:success)

    subscriber = FactoryBot.create(:subscriber)
    expect(page).to select(subscriber.name, from: "listing_amenity_id")
  end
end
