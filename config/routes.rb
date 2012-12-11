Satsuma::Application.routes.draw do
  get "events/index"

  get "events/show"

  get "schedules/show"

  get "networks/index"

  get "networks/show"

  resources :networks
  
  resources :schedules, :path => "/networks/:web_key/schedule/:period"
  
  match '/networks/:web_key/events'  => 'events#index'
  
  match '/networks/:web_key/events/:realtime_id'  => 'events#show'
  
  root :to => 'networks#index'
end
