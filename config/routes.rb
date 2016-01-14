Rails.application.routes.draw do
# devise_for :admin_users #ここを編集する（new)をできなくする
  root 'top#index'

#jsonの出力
  get 'api/product/search'  => 'api#apis_product_search'
  get 'api/ranking'         => 'api#ranking'
  get 'api/budget'          => 'api#budget'
  get 'api/detail'          => 'api#detail'

#下層ページ
  get 'company/agreement' => 'company#agreement'
  get 'company/privacy'   => 'company#privacy'
  get 'company/exchange'  => 'company#exchange'
  get 'company/question'  => 'company#question'
  get 'company/about'     => 'company#about'
  get 'company/flow'      => 'company#flow'
  get 'company/contact'   => 'company#contact'

#productの一覧
  get 'product/show/:id'  => 'products#show'
  get 'product/scene'     => 'products#scene'

#カートの追加
  get 'cart/show' =>'carts#show'
  get 'cart/register' => 'carts#register'
  get 'carts/comfirm' => 'carts#comfirm'
  get 'carts/thanks' => 'carts#thanks'
  post 'product/show'     => 'products#create_cart'

 # get 'feature/feature_list' => 'feature#show'

#商品購入
  post  'order/new'     =>  'orders#create'
  patch  'order/new'    =>  'orders#create'
#顧客情報入力
  get 'order/new'       =>  'orders#new'
  get 'order/complete'  =>  'orders#complete'


#以下管理画面のルーティング
  get   'admin/user/new'   => 'admin_users#new'
  post  'admin/user/new'   => 'admin_users#create'
#管理画面の商品関連
  post  'admin'          => 'admins#create'
  get   'admin/new'      => 'admins#new'
  get   'admin/:id/edit' => 'admins#edit'
  get   'admin/show'     => 'admins#show'
  patch 'admin/:id'      => 'admins#update'
  delete'admin/:id'      => 'admins#destroy'
#管理画面の購入した人一覧
  get   'admin/customer/:id/edit' => 'admin_customers#edit'
  get   'admin/customer/show'     => 'admin_customers#show'
  get   'admin/customer/index'    => 'admin_customers#index'
  patch 'admin/customer/:id'      => 'admin_customers#update'
  delete'admin/customer/:id'      => 'admin_customers#destroy'

resources :admin_balloon_options

#バルーンのオプションの選択--ここから
  get 'admin_balloon_options' => 'admin_balloon_options#create_boxsize'

  post 'colors/create'        => 'colors#create'
  post 'scenes/create'        => 'scenes#create'
  post 'characters/create'    => 'characters#create'
  post 'balloon_types/create' => 'balloon_types#create'

  get   'colors/:id/edit'     => 'colors#edit'
  patch 'colors/:id'          => 'colors#update'

  get   'characters/:id/edit' => 'characters#edit'
  patch 'characters/:id'      => 'characters#update'

  get   'scenes/:id/edit'     => 'scenes#edit'
  patch 'scenes/:id'          => 'scenes#update'

  get 'balloon_types/:id/edit'=> 'balloon_types#edit'
  patch 'balloon_types/:id'   => 'balloon_types#update'
#--ここまで
#管理画面のログイン関連
get    'admin/login'   => 'sessions#new'
post   'admin/login'   => 'sessions#create'
get  'logout'  => 'sessions#destroy' ,as: :logout

end