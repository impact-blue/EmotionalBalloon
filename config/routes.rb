Rails.application.routes.draw do
  root  'top#index'

  get 'api/get_json' => 'api#get_json'

end
