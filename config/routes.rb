Rails.application.routes.draw do
  devise_for :users
  root to: "turbolyapps#index"

  resources :turbolyapps
end
