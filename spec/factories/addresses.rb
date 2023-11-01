# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    postal_code { Faker::Address.zip_code }
    country { Faker::Address.country }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end

  trait :invalid_address do
    street { nil }
    city { nil }
    state { nil }
    postal_code { nil }
    country { nil }
    latitude { nil }
    longitude { nil }
  end
end
