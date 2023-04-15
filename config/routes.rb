Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  get 'static_pages/help',to: 'static_pages#help'
  get 'static_pages/contact',to: 'static_pages#contact'
  get 'static_pages/about',to: 'static_pages#about'
  get 'article/arhived', to: 'articles#arhived'
  delete 'articles/:id/restore', to: 'articles#restore', as: 'restore_article'
  delete 'articles/:id/arhive', to: 'articles#arhive', as: 'arhive_article'

  resources :articles do
    resources :comments
  end
end
