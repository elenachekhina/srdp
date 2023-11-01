# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :organization

  validates :name, presence: true
  validates :duration, presence: true
  validates :pricing, presence: true
  validates :currency, presence: true
end
