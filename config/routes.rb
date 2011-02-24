Mail2share::Application.routes.draw do
	

  resources :users 
  #resources :emails


  #Added by shams for collection
  resources :emails do
    collection do
      put :update_emails
    end
  end


	get "activations/create"

	match 'users/new' => 'users#new'
	match 'users/create' => 'users#create'
	match 'users/update' => 'users#update'
	match 'user_sessions/create' => 'user_sessions#create'
	match 'user_sessions/destroy' => 'user_sessions#destroy'
	match 'activate/:activation_code' => 'activations#create'
	match 'password_resets/new' => 'password_resets#new'
	match 'password_resets/create' => 'password_resets#create'
	match 'password_resets/edit' => 'password_resets#edit'
	match 'password_resets/update' => 'password_resets#update', :via => :put
	#match 'password_resets/update' => 'password_resets#update'
	match 'password_resets/:id' => 'password_resets#edit'
	
#	match 'users/show' => 'users#show'
#  match ":user" => 'users#index'



  #added by shams
  match '/:username', :to => "emails#inbox", :as => :emails
  match '/:username/:file_key', :to => "emails#messages"

  #added by shams
 # match '/signup',  :to => 'users#new'
 # match '/signin',  :to => 'sessions#new'
 # match '/signout', :to => 'sessions#destroy'
  

  #get "users/new"
  
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'


	root :to => 'user_sessions#new'

	
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
