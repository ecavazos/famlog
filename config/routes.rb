ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"
  map.resources :messages
  map.resources :events
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
