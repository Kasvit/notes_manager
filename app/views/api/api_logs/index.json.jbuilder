# frozen_string_literal: true

json.data do
  json.array! @api_logs, :endpoint, :request_method, :request_params, :response_status
end
