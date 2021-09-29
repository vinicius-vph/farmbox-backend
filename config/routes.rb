Rails.application.routes.draw do
  root to: 'home#index'

  resources :welcome, only: %i[index]

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show update create destroy]
      resources :field_notes, only: %i[index show update create destroy]
    end
  end
end
