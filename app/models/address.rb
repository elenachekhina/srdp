# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :organization

  validates :street, :city, :state, :postal_code, :country, presence: true
end
