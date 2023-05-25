Rails.application.routes.draw do
  resources :tasks do
    get "/logs", to: "tasks#logs"
  end
  devise_for :users

  root "tasks#index"
end
