Blog::Application.routes.draw do


  #resources is jsut a really fast way to declare a bunch of routes for things
  resources :users, only: [:edit, :update], :path => '/admin/users' #because the user functions are all admin only, we change the preface to include

  #posts
  resources :posts, except: [:index, :show], :path => '/admin/posts' 
  root to: 'posts#home_index', via: 'get'
  match '/admin/index', to: 'posts#admin_index', via: 'get'
  match '/posts/:id', to: 'posts#show', via: 'get' #these have to be routed to using public_post_path ion the posts_helper, which is really not ideal
  match '/posts', to: redirect('/'), via: 'get'


  #static pages
  match '/about', to: 'static_pages#about', via: 'get'
  match '/gallery', to: 'static_pages#gallery', via: 'get' #this may end up being photos#index
  match '/map', to: 'static_pages#map', via: 'get' #this may end up being maps#index
  match '/jet', to: 'static_pages#jet', via: 'get'
  match '/admin', to: 'static_pages#admin', via: 'get'

  #sessions
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete' 
  match '/authenticate', to: 'sessions#create', via: 'post'

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
