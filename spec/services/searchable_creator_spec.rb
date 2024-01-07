require 'rails_helper'

RSpec.describe SearchableCreator, type: :service do
  let(:klass) { double('Class') }
  let(:params) { { key: 'value' } }
  let(:object) { double('Object') }
  let(:meilisearch_service) { double(MeilisearchService) }

  let(:subject) { described_class.new(klass, params) }

  before do
    allow(MeilisearchService).to receive(:new).and_return(meilisearch_service)
    allow(meilisearch_service).to receive(:create)

    allow(klass).to receive(:new).with(params).and_return(object)
    allow(object).to receive(:searchable_fields)
    allow(subject).to receive(:create_meilisearch_document)
  end

  describe '#call' do
    context 'when the object is saved successfully' do
      before do
        allow(object).to receive(:save).and_return(true)

        subject.call
      end

      it 'creates a new instance of the class with given params' do
        expect(klass).to have_received(:new).with(params)
      end

      it 'saves the object' do
        expect(object).to have_received(:save)
      end

      it 'performs post create actions' do
        expect(subject).to have_received(:create_meilisearch_document)
      end

      it 'returns the object' do
        expect(subject.call).to eq(object)
      end
    end

    context 'when the object fails to save' do
      before do
        allow(object).to receive(:save).and_return(false)
      end

      it 'does not perform post create actions' do
        expect(subject).not_to have_received(:create_meilisearch_document)
      end

      it 'returns the object' do
        expect(subject.call).to eq(object)
      end
    end
  end
end
