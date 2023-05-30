require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  describe "associations" do
    it "has many requested quotes" do
      assc = described_class.reflect_on_association(:requested_quotes)
      expect(assc.macro).to eq :has_many
    end
  end
end
