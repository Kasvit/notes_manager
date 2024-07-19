# frozen_string_literal: true

class BaseService
  def self.call(*args, **kwargs, &block)
    new(*args, **kwargs, &block).call
  end

  def initialize(*args, **kwargs)
    @args = args
    @kwargs = kwargs
  end

  def call
    perform
  rescue StandardError => e
    handle_error(e)
  end

  private

  def perform
    raise NotImplementedError, 'Subclasses must implement the perform method'
  end

  def handle_error(error)
    Rails.logger.error("An error occurred: #{error.message}")
  end
end