require 'rails_helper'

RSpec.describe RatePolicy do
  let(:policy) { described_class.new(rate, user:) }

  let(:rate) { build(:rate, rateable:, rater: rater) }
  let(:rateable) { create(:organization) }
  let(:user) { create(:user) }
  let(:rater) { user }

  describe '#new?' do
    subject { policy.apply(:new?) }

    context 'when rater has already rated the rateable' do
      before { create(:rate, rateable: rateable, rater: user) }

      it { is_expected.to be_falsey }
    end

    context 'when rater has not rated the rateable' do
      it { is_expected.to be_truthy }
    end

    context 'when visitor' do
      let(:user) { nil }

      it { is_expected.to be_falsey }
    end
  end
end
