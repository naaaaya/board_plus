Rails.application.routes.draw do
  devise_for :users
  root 'my_threads#index'
  resources :my_threads do
    resources :comments
  end
end
