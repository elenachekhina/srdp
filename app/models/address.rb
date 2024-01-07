# frozen_string_literal: true

class Address < ApplicationRecord
  include Geocoder::Model::ActiveRecord
  include Searchable

  belongs_to :organization

  validates :street, :city, :state, :postal_code, :country, presence: true

  geocoded_by :to_s

  after_validation :geocode, if: ->(obj) { obj.changed? }

  def to_s
    [house_number, street, district, city, state, country].compact.join(', ')
  end

  def latitude
    self[:latitude_ovr] || self[:latitude]
  end

  def longitude
    self[:longitude_ovr] || self[:longitude]
  end

  def searchable_fields
    self.slice(:id, :street, :city, :district)
  end
end
