class Rate < ApplicationRecord
  belongs_to :rateable, polymorphic: true
  belongs_to :rater, polymorphic: true

  validates :value, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :rateable, presence: true
  validates :rater, presence: true
  validates :rater_id, uniqueness: { scope: %i[rater_type rateable_type rateable_id] }
end
