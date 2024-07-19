# frozen_string_literal: true

module ApiResponseErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  def not_found(exception)
    error_response({ title: 'Not Found', detail: exception.message }, :not_found)
  end

  def validation_error(active_record_model)
    error_response({
                     title: "#{active_record_model.class} validation error",
                     detail: active_record_model.errors.full_messages.join(', ')
                   },
                   :bad_request)
  end

  # error_object: { title: "Not Found", detail: "We can't find something"}
  # status: :not_found
  def error_response(error_object, status)
    render json: { errors: [error_object] }, status:
  end
end
