People::Application.routes.draw do
  root :to => 'meta#root'

  get 'articles/:id/related'      => 'articles#related'
  get 'programmes/:pid/related'   => 'programmes#related'
  scope '/profiles' do
    get '/'     => 'profiles#index'
    constraints :name => /[%A-Za-z0-9()\._\-,]+/ do
      get '/:name' => 'profiles#show', :as => 'show_profile', :format => false
      get '/:name/read' => 'profiles#read', :as => 'read_profile'
      get '/:name/listen/schedules' => 'profiles#radio_schedules', :as => 'radio_schedules'
      get '/:name/listen/player' => 'profiles#listen', :as => 'listen_profile'
      get '/:name/listen' => 'profiles#listen_all'
      get '/:name/watch/schedules' => 'profiles#tv_schedules', :as => 'tv_schedules'
      get '/:name/watch/player' => 'profiles#watch', :as => 'watch_profile'
      get '/:name/watch' => 'profiles#watch_all'
      get '/:name/edit'     => 'profiles#edit', :as => 'edit_profile'
      put '/:name/update'   => 'profiles#update'
      post '/:name/follow' => 'profiles#follow'
      post '/:name/unfollow' => 'profiles#unfollow'
    end
  end

  get '/meta'              => 'meta#index'
  get '/meta/chrome'       => 'meta#chrome', :as => 'chrome'
  get '/meta/chrome-extension' => 'meta#chrome_extension', :as => 'chrome_extension'
  get '/meta/design-notes' => 'meta#design'
  get '/meta/:action' => 'meta#:action'

  resources :users, :only => [:show, :index, :destroy] do
    member do
      get '/read' => 'users#read', :as => 'read_user'
      get '/listen' => 'users#listen_all', :as => 'listen_all_user'
      get '/listen/schedules' => 'users#radio_schedules', :as => 'radio_schedules_user'
      get '/listen/player' => 'users#listen', :as => 'listen_user'
      get '/watch/schedules' => 'users#tv_schedules', :as => 'tv_schedules_user'
      get '/watch/player' => 'users#watch', :as => 'watch_user'
      get '/watch' => 'users#watch_all'
    end
  end

  match "/auth/:provider/callback" => "sessions#create"
  get "logout" => "sessions#destroy"
end
