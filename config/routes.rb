# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  devise_scope :user do
    post 'users/sign_up', to: 'users/registrations#create'
    get 'users/registrations/complete/:id', to: 'users/registrations#details', as: :complete_user_registration
    put 'users/registrations/complete/:id', to: 'users/registrations#complete'
  end

  root to: 'organisations#index'

  resources :organisations do
    resources :teams, except: %i[index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
