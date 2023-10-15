# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Organization #{n}"
  end

  sequence :email_seq do |n|
    "email#{n}@gmail.com"
  end

  factory :organization do
    name
    email { generate(:email_seq) }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
