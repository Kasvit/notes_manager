# frozen_string_literal: true

require 'resque/server'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/resque'

  root 'home#welcome'

  defaults format: :json do
    namespace :api do
      resources :notes do
        collection do
          get :search
          post :import
        end
      end

      resources :api_logs, only: [:index] do
        get :search, on: :collection
      end
    end
  end
end
