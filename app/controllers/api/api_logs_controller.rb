# frozen_string_literal: true

module Api
  class ApiLogsController < ApiController
    def index
      @api_logs = ApiLog.all.to_a
    end

    def search
      @api_logs = ApiLog.where({})
      search_params(params).each do |key, value|
        @api_logs = @api_logs.public_send("filter_by_#{key}", value) if value.present?
      end

      render :index
    end

    private

    def search_params(params)
      params.slice(:endpoint, :request_method, :response_status)
    end
  end
end
