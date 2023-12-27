# frozen_string_literal: true

class Contact < ApplicationRecord
  CONTACT_TYPES = %w[phone email other].freeze

  belongs_to :organization

  validates :type, presence: true
  validates :value, presence: true
end
