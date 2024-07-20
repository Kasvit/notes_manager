# frozen_string_literal: true

class ApiLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :endpoint, type: String
  field :request_method, type: String
  field :request_params, type: Hash
  field :response_status, type: Integer

  scope :filter_by_endpoint, ->(endpoint) { where(endpoint: /#{endpoint}/i) }
  scope :filter_by_request_method, ->(request_method) { where(request_method: /#{request_method}/i) }
  scope :filter_by_response_status, ->(response_status) { where(response_status: response_status.to_i) }
end
