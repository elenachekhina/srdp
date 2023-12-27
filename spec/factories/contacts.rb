# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    type { 'Phone' }
    value { '123456789' }
  end

  trait :invalid do
    type { nil }
    value { nil }
  end
end
