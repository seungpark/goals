Rails.application.routes.draw do


  resources :users do
    resources :user_comments
  end
  resource :session
  resources :goals do
    resources :goal_comments
  end

  root to: "users#new"

end
