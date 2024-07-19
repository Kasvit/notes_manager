# frozen_string_literal: true

class ApiController < ApplicationController
  include ApiResponseErrorHandler
  protect_from_forgery with: :null_session
end
