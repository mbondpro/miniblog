Blog::Application.routes.draw do

  devise_for :users
  resources :categories do
    resources :posts
  end 
  resources :posts
  resources :comments
  
  match 'admin' => 'admin#index'
  match 'publish' => 'admin#publish'
  
  root :to => 'home#index'

end
