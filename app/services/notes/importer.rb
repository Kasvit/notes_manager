# frozen_string_literal: true

module Notes
  class Importer < BaseService
    def perform
      Notes::ImportMocked.call # or add condition to call external API
    end
  end
end