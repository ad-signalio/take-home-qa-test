# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'organisations#index'

  resources :organisations do
    resources :teams, except: %i[index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
