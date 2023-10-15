# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Email, type: :model do
  it { should validate_presence_of :value }

  it { should allow_value('test@example.com').for(:value) }
  it { should allow_value('test.user@example.co.uk').for(:value) }
  it { should_not allow_value('test').for(:value) }
  it { should_not allow_value('test@').for(:value) }
  it { should_not allow_value('@example.com').for(:value) }
end
