# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomeController', type: :request do
  describe 'GET /' do
    it 'return 200' do
      get root_path
      expect(response.status).to eq(200)
    end
  end
end
