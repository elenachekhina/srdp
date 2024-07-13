require 'rails_helper'

RSpec.describe Rate, type: :model do
  it { should validate_presence_of :value }
  it { should validate_numericality_of(:value).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5) }
  it { should validate_presence_of :rateable }
  it { should validate_presence_of :rater }
end
