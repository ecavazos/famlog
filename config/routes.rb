ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"
  map.resources :users
  map.resource :user_session, :as => "session"
  map.resources :messages
  map.resources :events
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
