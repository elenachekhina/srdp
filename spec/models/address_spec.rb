# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:country) }
  end

  describe 'Associations' do
    it { should belong_to(:organization) }
  end

  describe 'Geocoding' do
    it 'should geocode address after validation' do
      address = build(:address)
      expect(address).to receive(:geocode)
      address.valid?
    end

    it 'should return latitude_ovr if present' do
      address = build(:address, latitude_ovr: 41.44, longitude_ovr: 42.22)
      expect(address.latitude).to eq(address[:latitude_ovr])
    end

    it 'should return latitude if latitude_ovr not present' do
      address = build(:address, latitude_ovr: nil, longitude_ovr: nil)
      expect(address.latitude).to eq(address[:latitude])
    end
  end
end
