# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_name { 'user_name' }
    email { 'email@email.com' }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :update_user do
      user_name { 'update_user_name' }
      first_name { 'first_name' }
      last_name { 'last_name' }
      date_of_birth { '2021-10-10' }
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'default-avatar.png')) }
    end

    trait :invalid_user do
      user_name { nil }
    end
  end
end
