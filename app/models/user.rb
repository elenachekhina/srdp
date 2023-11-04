class User < ApplicationRecord
  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
