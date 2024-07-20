# frozen_string_literal: true

class ApiController < ApplicationController
  include ApiResponseErrorHandler
  protect_from_forgery with: :null_session

  after_action :log_action

  private

  def log_action
    ApiLog.create(
      endpoint: request.path,
      request_method: request.request_method,
      request_params: request.params.except(:controller, :action),
      response_status: response.status
    )
  end
end
