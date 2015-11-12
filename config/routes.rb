Rails.application.routes.draw do
  root  'top#index'

  get 'api/show' => 'api#show'

#mount API => "/api"
end
