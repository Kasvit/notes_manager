# frozen_string_literal: true

require 'rails_helper'

describe BaseService do
  describe '#call' do
    context 'when the perform method is stubbed' do
      before do
        allow_any_instance_of(BaseService).to receive(:perform)
      end

      it 'calls the perform method' do
        service_instance = described_class.new
        service_instance.call
        expect(service_instance).to have_received(:perform)
      end
    end

    context 'when the perform method is not implemented' do
      it 'raises NotImplementedError' do
        expect { described_class.call }.to raise_error(NotImplementedError)
      end
    end
  end
end
