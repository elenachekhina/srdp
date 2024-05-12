# frozen_string_literal: true

class Service < ApplicationRecord
  include Searchable

  belongs_to :organization

  validates :name, presence: true
  validates :duration, presence: true
  validates :pricing, presence: true
  validates :currency, presence: true
end
