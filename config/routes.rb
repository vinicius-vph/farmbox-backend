Rails.application.routes.draw do
  root to: 'home#index'

  resources :welcome, only: %i[index]

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index new create show destroy]
      resources :field_notes, only: %i[index new create show destroy]
    end
  end
end
