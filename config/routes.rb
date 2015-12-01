Rails.application.routes.draw do
  get 'session/new'

  devise_for :admin_users #ここを編集する（new)をできなくする
  root  'top#index'

  get 'api/show' => 'api#show'


  get 'company/agreement' => 'company#agreement'
  get 'company/privacy' =>'company#privacy'
  get 'company/exchange' => 'company#exchange'
  get 'company/question' => 'company#question'
  get 'company/about' => 'company#about'
  get 'company/flow' => 'company#flow'
  get 'company/contact' => 'company#contact'

  get 'product/show' => 'product/product_shows#show'
  get 'product/list' => 'product/product_lists#show'
  get 'product/ranking' => 'product/product_rankings#show'
  get 'product/search' => 'product/product_searchs#show'

  get 'feature/feature_list' => 'feature#show'

  get 'admin/show' => 'admin#show'

end