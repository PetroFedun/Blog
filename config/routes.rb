Rails.application.routes.draw do
  root "articles#index"
  get 'static_pages/help',to: 'articles#help'
  get 'static_pages/sign',to: 'articles#sign'
  get 'static_pages/contact',to: 'articles#contact'
  get 'static_pages/about',to: 'articles#about'

  resources :articles do
    resources :comments
  end
end
