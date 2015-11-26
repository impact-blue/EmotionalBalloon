Rails.application.routes.draw do
  root  'top#index'

  get 'api/show' => 'api#show'


  get 'company/agreement' => 'company#agreement'
  get 'company/privacy' =>'company#privacy'
  get 'company/exchange' => 'company#exchange'
  get 'company/question' => 'company#question'
  get 'company/about' => 'company#about'
  get 'company/flow' => 'company#flow'
  get 'company/contact' => 'company#contact'


#mount API => "/api"
end