# frozen_string_literal: true

class Email < Contact
  validates :value, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'only allows valid emails' }
end
