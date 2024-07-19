# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notes::Importer do
  describe '#perform' do
    it 'calls Notes::ImportMocked.call' do
      allow(Notes::ImportMocked).to receive(:call)

      described_class.call
      expect(Notes::ImportMocked).to have_received(:call)
    end
  end
end