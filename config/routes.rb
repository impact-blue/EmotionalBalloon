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

#商品購入
post  'order'    => 'orders#create'
patch  'order'    => 'orders#create'
#顧客情報入力
get 'order/new' => 'orders#new'
get 'order/complete'  =>  'orders#complete'

#以下管理画面のルーティング
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
post 'balloontypes/create' => 'balloontypes#create'

get 'colors/:id/edit' => 'colors#edit'
patch 'colors/:id' => 'colors#update'

get 'characters/:id/edit' => 'characters#edit'
patch 'characters/:id' => 'characters#update'

get 'scenes/:id/edit' => 'scenes#edit'
patch 'scenes/:id' => 'scenes#update'

get 'balloontypes/:id/edit' => 'balloontypes#edit'
patch 'balloontypes/:id' => 'balloontypes#update'

#管理画面のログイン関連
get    'admin/login'   => 'sessions#new'
post   'admin/login'   => 'sessions#create'
get 'logout'  => 'sessions#destroy' ,as: :logout

end