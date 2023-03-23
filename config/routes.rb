Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  get 'static_pages/help',to: 'static_pages#help'
  get 'static_pages/contact',to: 'static_pages#contact'
  get 'static_pages/about',to: 'static_pages#about'
  
  resources :articles do
    resources :comments
  end
end
