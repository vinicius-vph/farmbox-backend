Rails.application.routes.draw do
  root 'home#index'

  resources :welcome, only: %i[index]
end
