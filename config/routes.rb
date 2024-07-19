# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#welcome'

  defaults format: :json do
    namespace :api do
      resources :notes do
        collection do
          get 'search'
        end
      end
    end
  end
end
