Rails.application.routes.draw do
# devise_for :admin_users #ここを編集する（new)をできなくする
  root 'top#index'

#jsonの出力
  get 'api/products/search'  => 'api#apis_product_search'
  get 'api/products/ranking'         => 'api#ranking'
  get 'api/products/budget'          => 'api#budget'
  get 'api/products/detail'          => 'api#detail'
  #post 'api/carts/confirm' => '#confirm'

#下層ページ
  get 'company/agreement' => 'company#agreement'
  get 'company/privacy'   => 'company#privacy'
  get 'company/exchange'  => 'company#exchange'
  get 'company/question'  => 'company#question'
  get 'company/about'     => 'company#about'
  get 'company/flow'      => 'company#flow'
  get 'company/contact'   => 'company#contact'

#productの一覧
  get 'products/show'  => 'products#show'
  get 'products/scene'     => 'products#scene'
  get 'products' => 'products#index'
  get 'products/ranking' => 'products#ranking'

#カートの追加
  get 'carts/show' =>'carts#show'
  get 'carts/register' => 'carts#register'
  get 'carts/comfirm' => 'carts#comfirm'
  post 'carts/confirm' => 'carts#thanks'
  get 'carts/thanks' => 'carts#thanks'
  post 'products/show'     => 'products#create_cart'

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

#管理画面ホーム
get "admin" => "admin#index"

#管理画面の商品関連
  resources :admin_products,:path => 'admin/products'

#管理画面の注文一覧
  resources :admin_orders,:path  =>  'admin/orders'

#管理画面の購入した人一覧
  resources :admin_customers,only: [:index,:show,:edit,:update,:destroy],:path => 'admin/customers'
#TODO: 設定のコントローラー作成
  resources :admin_settings,only:[:index],:path => 'admin/settings'

resources :admin_balloon_options
#バルーンのオプションの選択--ここから

 resources :admin_categories, only:[:index,:new,:create,:update] , :path => 'admin/categories' do
 #,shallow: true do
  resources :admin_category_children, only:[:index,:new,:create,:update] , :path => 'sub_categories'
 end

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