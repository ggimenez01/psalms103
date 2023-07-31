Rails.application.routes.draw do
  get 'products/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'cart', to: 'carts#show', as: :cart
  root 'products#index'
  get 'checkout', to: 'checkout#new', as: 'checkout'
  get '/best_selling', to: 'drugs#best_selling'
  resources :orders, only: [:show, :create]





  # products page 
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member
    get 'cart', on: :collection
    put 'update_cart', on: :collection
    delete 'remove_item', on: :collection
    collection do
      get :on_sale
      get :new_products
      get :recently_updated
    end
  end

  #categories page
  resources :categories, only: [:index, :show] do
    collection do
      get :otc
      get :prescription
      get :branded
      get :generic
    end
  end
end
