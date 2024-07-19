# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notes::ImportMocked do
  describe '#perform' do
    before do
      file_path = Rails.root.join('public', 'mocked_notes.json')
      expect(File).to exist(file_path)
    end

    it 'creates notes from mocked_notes.json' do
      expect { described_class.new.perform }.to change { Note.count }.by(10)

      note1 = Note.find_by(title: 'Sample Note 1')
      note2 = Note.find_by(title: 'Sample Note 2')

      expect(note1).to be_present
      expect(note2).to be_present
      expect(note1.content).to eq('This is a sample note 1.')
      expect(note2.content).to eq('This is another sample note 2.')
    end
  end
end