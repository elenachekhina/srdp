# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    organization { create(:organization) }

    name { 'Service name' }
    description { 'Service description' }
    duration { 120 }
    pricing { 120.0 }
    currency { 'USD' }
  end

  trait :invalid_service do
    name { nil }
  end
end
