# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
