Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  get 'static_pages/help',to: 'static_pages#help'
  get 'static_pages/contact',to: 'static_pages#contact'
  get 'static_pages/about',to: 'static_pages#about'
  get 'archived_articles', to: 'articles#archived_articles'
  patch 'articles/:id/restore', to: 'articles#restore', as: 'restore_article'
  patch 'articles/:id/arhive', to: 'articles#arhive', as: 'arhive_article'

  resources :articles do
    resources :comments
  end
end
