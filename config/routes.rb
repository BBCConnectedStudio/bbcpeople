People::Application.routes.draw do
  root :to => 'meta#root'

  get 'articles/:id/related'      => 'articles#related'
  scope '/profiles' do
    get '/'     => 'profiles#index'
    get '/:name' => 'profiles#show', :as => 'show_profile', :format => false, :constraints => {:name => /[%A-Za-z0-9()\._\-]+/}
    get '/:name/read' => 'profiles#read', :as => 'read_profile'
    get '/:name/listen/schedules' => 'profiles#radio_schedules', :as => 'radio_schedules'
    get '/:name/listen/player' => 'profiles#listen', :as => 'listen_profile'
    get '/:name/listen' => 'profiles#listen_all'
    get '/:name/watch/schedules' => 'profiles#tv_schedules', :as => 'tv_schedules'
    get '/:name/watch/player' => 'profiles#watch', :as => 'watch_profile'
    get '/:name/watch' => 'profiles#watch_all'
  end

  get '/meta'              => 'meta#index'
  get '/meta/chrome'       => 'meta#chrome', :as => 'chrome'
  get '/meta/chrome-extension' => 'meta#chrome_extension', :as => 'chrome_extension'
  get '/meta/:action' => 'meta#:action'

  resources :users

  match "/auth/:provider/callback" => "sessions#create"
end
