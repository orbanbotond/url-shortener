# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "short_urls#index"

  mount Api::Endpoints => '/'

  resources :short_urls, only: %i[index create] do
    post :decode, on: :collection
  end
end
