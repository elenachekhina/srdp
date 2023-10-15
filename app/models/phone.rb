# frozen_string_literal: true

class Phone < Contact
  validates :value, format: { with: /\A\+?[0-9]+\z/, message: 'only allows numbers' }
end
