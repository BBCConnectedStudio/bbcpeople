People::Application.routes.draw do
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
  root :to => 'profiles#index'

  get 'people'        => 'profiles#index'
  get 'articles/:id/related'      => 'articles#related'
  scope '/profiles' do
    get '/:name' => 'profiles#show', :as => 'show_profile', :format => false, :constraints => {:name => /[%A-Za-z0-9()\._\-]+/}
    get '/:name/read' => 'profiles#read', :as => 'read_profile'
    get '/:name/listen/schedules' => 'profiles#radio_schedules', :as => 'radio_schedules'
    get '/:name/listen/player' => 'profiles#listen', :as => 'listen_profile'
    get '/:name/listen' => 'profiles#listen_all'
    get '/:name/watch/schedules' => 'profiles#tv_schedules', :as => 'tv_schedules'
    get '/:name/watch/player' => 'profiles#watch', :as => 'watch_profile'
    get '/:name/watch' => 'profiles#watch_all'
  end

  get '/meta/chrome'       => 'meta#chrome', :as => 'chrome'
  get '/meta/chrome-extension' => 'meta#chrome_extension', :as => 'chrome_extension'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
