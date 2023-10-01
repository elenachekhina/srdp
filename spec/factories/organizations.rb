# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Organization #{n}"
  end

  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  factory :organization do
    name
    email
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
