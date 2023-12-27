# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  it { should validate_presence_of :value }

  it { should allow_value('+1234567890').for(:value) }
  it { should allow_value('1234567890').for(:value) }

  it { should_not allow_value('1234abc').for(:value) }
  it { should_not allow_value('+ 1234567890').for(:value) }
  it { should_not allow_value('').for(:value) }
  it { should_not allow_value('+').for(:value) }
end
