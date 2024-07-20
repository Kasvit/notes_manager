# frozen_string_literal: true

FactoryBot.define do
  factory :api_log do
    endpoint { '/api/notes' }
    request_method { 'GET' }
    request_params { { format: :json } }
    response_status { 200 }
  end
end
