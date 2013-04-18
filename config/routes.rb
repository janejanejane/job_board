JobBoard::Application.routes.draw do
  resources :jobs do
    get :preview, on: :new
    get 'category/:name', on: :collection, action: :category, as: :category
    member do
      get :confirm
      get :success
      get :error
    end
  end

  # resources :category, except: [:index, :create, :new, :edit, :update, :destroy] 
  resources :users, only: [:index, :show, :edit, :update] do
    get 'category/:name', on: :collection, action: :category, as: :category
    resources :games, except: [:new]
    resources :extras, except: [:new, :edit, :destroy]
    member do
      post :vote
      post :plus
      post :minus
    end
  end

  #get "jobs/new"

  #root to: 'static_pages#home'
  root to: 'jobs#index'
  
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'jobs/*page', to: 'jobs#index'
  match 'category/*page', to: 'jobs#index'
  match '/about', to: 'static_pages#about'
  match '/*page', to: 'jobs#index'
  #match '/signup', to: 'jobs#new'
  #match '/help', to: 'static_pages#help'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
