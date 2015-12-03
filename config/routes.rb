Rails.application.routes.draw do
  get 'characters/create'

  get 'scenes/create'

  get 'colors/create'

 # devise_for :admin_users #ここを編集する（new)をできなくする
root  'top#index'

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

#管理画面の商品関連
post  'admin'          => 'admins#create'
get   'admin/new'      => 'admins#new'
get   'admin/:id/edit' => 'admins#edit'
get   'admin/show'     => 'admins#show'
patch 'admin/:id'      => 'admins#update'
delete'admin/:id'      => 'admins#destroy'

resources :admin_balloon_options

get 'admin_balloon_options' => 'admin_balloon_options#create_boxsize'

post 'colors/create' => 'colors#create'
post 'scenes/create' => 'scenes#create'
post 'characters/create' => 'characters#create'

#管理画面のログイン関連
get    'admin/login'   => 'sessions#new'
post   'admin/login'   => 'sessions#create'
get 'logout'  => 'sessions#destroy' ,as: :logout

end