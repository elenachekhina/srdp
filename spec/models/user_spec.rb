# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :user_name }
  it { should validate_presence_of :email }
end
