Blog::Application.routes.draw do


  get "posts/index"
  get "posts/show"
  get "posts/new"
  get "posts/create"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  resources :users, only: [:edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  

  #match '/index', to: 'posts#index', via: 'get'


  #these are gets, but they're fine the way they are - nobodoy should care about these urls anyway
  get "users/edit"
  get "users/update"


  #root to: 'static_pages#home'
  root to: 'posts#index', via: 'get'

  match '/about', to: 'static_pages#about', via: 'get'
  match '/gallery', to: 'static_pages#gallery', via: 'get' #this may end up being photos#index
  match '/map', to: 'static_pages#map', via: 'get' #this may end up being maps#index
  match '/jet', to: 'static_pages#jet', via: 'get'
  match '/admin', to: 'static_pages#admin', via: 'get'

  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete' 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
