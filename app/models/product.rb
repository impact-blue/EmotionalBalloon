class Product < ActiveRecord::Base
  has_many :product_colors
  has_many :colors, through: :product_colors
  has_many :product_charas
  has_many :charas, through: :product_charas
  has_many :product_balloon_types
  has_many :balloon_types, through: :product_balloon_types
  has_many :images
  has_many :orders, through: :product_orders
  has_many :product_scenes
  has_many :scenes, through: :product_scenes
  belongs_to :boxsize
  has_many :carts

  has_many :product_category_children
  has_many :product_category_children, through: :product_category_child


  #商品番号
  #validates :number,  presence: { message: 'は必須です' }

  #商品名
  validates :name,  presence: { message: 'は必須です' }

  #画像
  #validates :image

  #価格,
  validates :price,  :numericality => { :only_integer => true , message: 'は必須です'}

  #在庫
  validates :stocks,  presence: { message: 'は必須です' }

  #送料 validates :postage

  #コメント、推薦文、キーワード
#validates :comment ,:keyword , :recommended

  #登録日
  validates :registration_date,  presence: { message: 'は必須です' }

  #箱サイズ
  validates :boxsize_id,  presence: { message: 'は必須です' }

end