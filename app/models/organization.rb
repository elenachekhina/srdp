# frozen_string_literal: true

class Organization < ApplicationRecord
  has_secure_password
  include Searchable
  include Rateable

  has_one_attached :logo

  has_one :address
  has_many :contacts
  has_many :services
  has_many :rates, as: :rateable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
