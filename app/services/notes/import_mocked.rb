# frozen_string_literal: true

module Notes
  class ImportMocked < BaseService
    def perform
      file = File.read(Rails.root.join('public', 'mocked_notes.json'))
      notes = JSON.parse(file)
      notes.each do |note|
        Note.create!(title: note['title'], content: note['content'])
      end
    end
  end
end
