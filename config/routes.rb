Blog::Application.routes.draw do


  #subscription
  match '/subscribe/:confirm_token', to: 'subscriptions#activate', via: 'get', as: 'subscribe_activate'
  match '/unsubscribe/:confirm_token', to: 'subscriptions#destroy', via: 'get', as: 'unsubscribe'
  match '/subscribe_init', to: 'subscriptions#init', via: 'post', as: 'subscribe_init' #['post', 'get']
  match '/subscribe_resend', to: 'subscriptions#resend', via: 'post', as: 'subscribe_resend'

  #categories
  resource :categories, only: [:create], :path => '/admin/categories'
  match '/admin/categories/:id', to: 'categories#destroy', via: 'delete', as: 'destroy_category'
 
  #users
  resources :users, only: [:edit, :update], :path => '/admin/users' #because the user functions are all admin only, we change the preface to include

  #posts
  resources :posts, except: [:index, :show], :path => '/admin/posts' 
  root to: 'posts#home_index', via: 'get'
  match '/admin/index', to: 'categories#index', via: 'get'
  match '/posts/:id', to: 'posts#show', via: 'get', as: 'public_post' #this generates public_post_path
  match '/posts', to: redirect('/'), via: 'get'
  match '/tag/:tag', to: 'posts#search_index', via: 'get', as: 'search_tag'
  match '/category/:category', to: 'posts#search_index', via: 'get', as: 'search_category'
  match '/search', to: 'posts#search_index', via: 'get', as: 'search'

  #pictures
  match '/admin/pictures/new', to: 'pictures#new', via: 'get'
  match '/admin/pictures/create', to: 'pictures#create', via: 'post'
  match '/gallery', to: 'pictures#index', via: 'get'

  #ajax pictures
  match '/pictures_large', to: 'pictures#large', via: 'post'
  match '/pictures_medium', to: 'pictures#medium', via: 'post'
  match '/pictures_thumb', to: 'pictures#thumb', via: 'post'
  match '/pictures_name', to: 'pictures#name', via: 'post'


  #static pages
  match '/about', to: 'static_pages#about', via: 'get'
  match '/map', to: 'static_pages#map', via: 'get' #this may end up being maps#index
  match '/jet', to: 'static_pages#jet', via: 'get'
  match '/admin', to: 'static_pages#admin', via: 'get'

  #sessions
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete' 
  match '/authenticate', to: 'sessions#create', via: 'post'


  #Catch all for extra routes; this _MUST_ be the last thing in the routing file
  match "*a", :to => "application#routing_error", via: 'get'

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
