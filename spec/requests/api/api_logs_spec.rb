# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::ApiLogsController', type: :request do
  describe 'GET /api/api_logs' do
    it 'returns 200' do
      get api_api_logs_path
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(data: [])
      expect(ApiLog.count).to eq(1)
    end
  end

  describe 'GET /api/api_logs/search' do
    let(:api_log) { create(:api_log, endpoint: '/api/notes', response_status: 200, request_method: 'GET') }

    before { api_log }

    context 'when found a log' do
      it 'returns an api log' do
        expect(ApiLog.count).to eq(1)
        get search_api_api_logs_path, params: { request_method: 'GET' }
        expect(JSON.parse(response.body, symbolize_names: true)[:data].size).to eq(1)
        expect(ApiLog.count).to eq(2)
      end
    end

    context "when didn't find a note" do
      it 'returns a blank array' do
        expect(ApiLog.count).to eq(1)
        get search_api_api_logs_path, params: { response_status: 201 }
        expect(JSON.parse(response.body, symbolize_names: true)[:data].size).to eq(0)
        expect(ApiLog.count).to eq(2)
      end
    end
  end
end
