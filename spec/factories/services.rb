FactoryBot.define do
  factory :service do
    name { "Service name" }
    description { "Service description" }
    duration { 120 }
    pricing { 120.0 }
    currency { 'USD' }
  end

  trait :invalid_service do
    name { nil }
  end
end
