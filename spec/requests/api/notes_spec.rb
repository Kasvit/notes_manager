# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::NotesController', type: :request do
  describe 'GET /api/notes' do
    it 'returns 200' do
      get api_notes_path
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(data: [])
      expect(ApiLog.count).to eq(1)
    end
  end

  describe 'GET /api/note/:id' do
    let(:note) { create(:note) }
    let(:expected_response) do
      {
        data: {
          type: 'note',
          id: note.id,
          attributes: {
            title: note.title,
            content: note.content
          }
        }
      }
    end

    it 'returns 200' do
      get api_note_path(note)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
      expect(ApiLog.count).to eq(1)
    end

    it 'returns error with invalid id' do
      get api_note_path(111)
      expect(JSON.parse(response.body,
                        symbolize_names: true)).to eq({ errors: [{ title: 'Not Found',
                                                                   detail: "Couldn't find Note with 'id'=111" }] })
      expect(ApiLog.count).to eq(1)
    end
  end

  describe 'POST /api/notes' do
    context 'with valid params' do
      it 'creates a new note' do
        post api_notes_path, params: { note: { title: 'new title', content: 'content' } }
        note = Note.last
        expect(JSON.parse(response.body, symbolize_names: true)[:data][:id]).to eq(note.id)
        expect(ApiLog.count).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'returns an error message' do
        post api_notes_path, params: { note: { title: 'without content' } }
        expect(JSON.parse(response.body,
                          symbolize_names: true)).to eq({ errors: [{ detail: "Content can't be blank",
                                                                     title: 'Note validation error' }] })
        expect(ApiLog.count).to eq(1)
      end
    end
  end

  describe 'PUT /api/notes/:id' do
    let(:note) { create(:note) }
    let(:expected_response) do
      {
        data: {
          type: 'note',
          id: note.id,
          attributes: {
            title: 'Updated Title',
            content: note.content
          }
        }
      }
    end

    context 'with valid parameters' do
      it 'updates the requested note' do
        put api_note_path(note), params: { note: { title: 'Updated Title' } }
        note.reload

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
        expect(ApiLog.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        put api_note_path(note), params: { note: { title: '' } }
        note.reload

        response_data = JSON.parse(response.body, symbolize_names: true)
        expect(response_data).to eq({ errors: [{ detail: "Title can't be blank", title: 'Note validation error' }] })
        expect(ApiLog.count).to eq(1)
      end
    end
  end

  describe 'DELETE /api/notes/:id' do
    let(:note) { create(:note) }\

    before { note }

    it 'deletes the requested note' do
      expect do
        delete api_note_path(note)
      end.to change(Note, :count).by(-1)

      expect(response).to have_http_status(:no_content)
      expect(ApiLog.count).to eq(1)
    end
  end

  describe 'GET /api/notes/search' do
    let(:note) { create(:note, title: 'test', content: 'welcome') }

    before { note }

    context 'when found a note' do
      it 'returns a note' do
        get search_api_notes_path, params: { query: 'test' }
        expect(JSON.parse(response.body, symbolize_names: true)[:data].size).to eq(1)
        expect(ApiLog.count).to eq(1)
      end
    end

    context "when didn't find a note" do
      it 'returns a blank array' do
        get search_api_notes_path, params: { query: 'John' }
        expect(JSON.parse(response.body, symbolize_names: true)[:data].size).to eq(0)
        expect(ApiLog.count).to eq(1)
      end
    end
  end

  describe 'POST /api/notes/import' do
    it 'generate notes' do
      expect do
        post import_api_notes_path
      end.to change(Note, :count).by(10)

      expect(response.status).to eq(200)
      expect(ApiLog.count).to eq(1)
    end
  end
end
