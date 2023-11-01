# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service, type: :model do
  it { should belong_to(:organization) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:pricing) }
  it { should validate_presence_of(:currency) }
end
