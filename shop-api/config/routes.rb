Rails.application.routes.draw do
  health_check_routes

  resources :categories
  resources :products
end