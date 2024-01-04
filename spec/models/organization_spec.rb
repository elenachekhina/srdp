# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/searchable'

RSpec.describe Organization, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }

  it_behaves_like 'Searchable' do
    let(:klass) { described_class }
  end
end
