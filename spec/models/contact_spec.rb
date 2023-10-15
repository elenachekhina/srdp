# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should belong_to(:organization) }
  it { should validate_presence_of :type }
  it { should validate_presence_of :value }
end
