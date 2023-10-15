# frozen_string_literal: true

class Organization < ApplicationRecord
  has_secure_password

  has_one_attached :logo

  has_one :address
  has_many :contacts

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
