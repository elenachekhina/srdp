class Contact < ApplicationRecord
  belongs_to :organization

  validates :website_url, format: { with: URI.regexp, message: "You provided an invalid URL" }, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
