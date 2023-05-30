# spec/factories.rb
require "faker"

FactoryBot.define do
  random = Faker::Address
  _city = random.city
  _street = random.street_address
  _number = random.building_number
  _bus = random.secondary_address
  _postal_code = random.postcode
  _zip_code = random.zip_code
  _state = random.state
  _latitude = random.latitude
  _longitude = random.longitude
  _country = random.country
  #_country_code = random.country_code #results[0] && results[1] ? Geocoder.search([results[0], results[1]]).first.country_code : nil

  factory :location do
    city { _city }
    street { _street }
    number { _number }
    bus { _bus }
    postal_code { _postal_code }
    latitude { _latitude }
    longitude { _longitude }
    zip_code { _zip_code }
    state { _state }
    country { _country }
    #country_code { _country_code }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :subscriber do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    message { Faker::Lorem.paragraph }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
