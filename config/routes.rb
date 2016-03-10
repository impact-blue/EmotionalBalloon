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
  get  'company/agreement' => 'company#agreement'
  get  'company/privacy'   => 'company#privacy'
  get  'company/exchange'  => 'company#exchange'
  get  'company/question'  => 'company#question'
  get  'company/about'     => 'company#about'
  get  'company/flow'      => 'company#flow'
  get  'company/contact'   => 'company#contact'
  post 'company/contact'   => 'company#create_contact'

#productの一覧
  get 'products/:id'  => 'products#show'
  get 'scenes/:category_name'     => 'products#index'
  get 'characters/:category_name'     => 'products#index'
  get 'search' => 'products#index'
  get 'ranking'   => 'products#ranking'

#カートの追加
  get  'carts/show'        => 'carts#show'
  get  'carts/register'    => 'carts#register'
  get  'carts/comfirm'     => 'carts#comfirm'
  post 'api/carts/comfirm' => 'carts#api' #購入
  get  'carts/thanks'      => 'carts#thanks'
  post 'carts/confirm'     => 'carts#purchase'

#以下管理画面のルーティング
  resources :admin_users,only: [:index,:new,:create],:path => 'admin/settings/users'
  get 'admin/settings/users/:id' => 'admin_users#destroy'

  resources :admin_settings,only:[:index],:path => 'admin/settings'
  get   'admin/settings/agreement' => 'admin_settings#edit_agreement'
  patch 'admin/settings/agreement' => 'admin_settings#update_agreement'
  get   'admin/settings/traderule' => 'admin_settings#edit_trade_rule'
  patch 'admin/settings/traderule' => 'admin_settings#update_trade_rule'
  get   'admin/settings/company'   => 'admin_settings#edit_company'
  patch 'admin/settings/company'   => 'admin_settings#update_company'
#管理画面メールテンプレート
  get   'admin/mails'      => 'admin_mails#edit'
  patch 'api/mails/edit'   => 'admin_mails#api'
#管理画面ホーム
  get "admin" => "admin#index"

#管理画面お問い合わせ
  get   'admin/contacts'     =>  'admin_contacts#index'
  get   'admin/contacts/:id/edit' =>  'admin_contacts#edit'
  patch 'api/contacts/edit' =>  'admin_contacts#api'

#管理画面の商品関連
  resources :admin_products,:path => 'admin/products'
  post  'api/products/edit'     => 'admin_products#api'
  patch 'api/products/edit'     => 'admin_products#api'
  post  'admin/products/import' => 'admin_products#import'

#管理画面の注文一覧
  resources :admin_orders,:path  =>  'admin/orders'
#管理画面の購入した人一覧
  resources :admin_customers,only: [:index,:show],:path => 'admin/customers'

#バルーンのオプションの選択--ここから
 resources :admin_categories, only:[:index,:new,:create,:update] , :path => 'admin/categories'
  get 'admin/categories/scene/:id/edit' => 'admin_categories#edit'
  get 'admin/categories/character/:id/edit' => 'admin_categories#edit'
  get 'admin/categories/scene/new' => 'admin_categories#edit'
  get 'admin/categories/character/new' => 'admin_categories#edit'
  patch 'api/categories/scenes'     => 'admin_categories#api_scene'
  patch 'api/categories/characters' => 'admin_categories#api_chara'


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

  resources :images,only:[:index,:new,:create],:path => 'admin/images'
  get 'admin/images/get_image'=>'images#get_image'
  get  'api/image' => 'images#api'
#--ここまで
#管理画面のログイン関連
get    'admin/login'   => 'sessions#new'
post   'admin/login'   => 'sessions#create'
get    'admin/logout'  => 'sessions#destroy' ,as: :logout

#match '*path' =>  'application#error404',via: :all

end