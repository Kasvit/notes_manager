require 'rails_helper'

RSpec.describe NoteImporterJob do
  describe '.perform' do
    it 'calls Notes::Importer' do
      expect(Notes::Importer).to receive(:call)
      NoteImporterJob.perform
    end
  end
end