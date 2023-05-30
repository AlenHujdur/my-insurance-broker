# spec/models/subscriber_spec.rb
require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Subscriber, type: :model do
  describe 'validations' do
    it 'is valid with attributes' do
      subscriber = FactoryBot.build(:subscriber)
      expect(subscriber).to be_valid
    end

    it 'is not valid without a email' do
      subscriber = FactoryBot.build(:subscriber, email: nil)
      expect(subscriber.valid?).to be false
      expect(subscriber.errors[:email]).to include("can't be blank")
    end

    it 'requires an email' do
      subscriber = FactoryBot.build(:subscriber, email: nil)
      expect(subscriber.valid?).to be false
      expect(subscriber.errors[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      existing_subscriber = FactoryBot.create(:subscriber, email: 'test@example.com')
      subscriber = FactoryBot.build(:subscriber, email: 'test@example.com')
      expect(subscriber.valid?).to be false
      expect(subscriber.errors[:email]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it { should have_many(:requested_quotes) }
  end
end
