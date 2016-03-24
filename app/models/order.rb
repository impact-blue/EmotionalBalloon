class Order < ActiveRecord::Base
  has_many :products, through: :order_product_infos
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :scene
  has_many   :order_product_infos
  has_many :order_delivery_names
  #has_many :user_names

  accepts_nested_attributes_for :order_delivery_names
  accepts_nested_attributes_for :user

 # validates :user_id,
 #   numericality: {only_integer: true}
  validates :price, presence: true,
                             numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}
  #postal_codeのバリデーション
  validates :postal_code,
    presence: { message: 'は必須です' },
    numericality: {only_integer: true, :message => "は半角数字のみ入力できます" },
    length: {maximum: 9,wrong_length: 'の桁数が違います。'}

  validates :city ,:payment_info, :delivery_address,:order_status,
    presence: { message: 'は必須です' },
    exclusion: { in: %w({ }  . [ ] ) }

  #delivery_phoneのバリデーション
  validates :delivery_phone,
    presence:  { message: 'は必須です' },
    length: { in: 10..15 , message: 'は10桁から15桁です。'},
    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}

  validates :option,
    exclusion: { in: %w({ }  . [ ] ) }


#order_dateはやってない。create_atでよくね？

#必要な検索
#name
#user.customer_phone
#ID
#created_at（絞り込み）
#targetでカラム指定、searchで検索内容、date_start,date_endで検索期間を指定。
  def self.get_list_all(page,per,order_by,target,search,max_price,min_price)
    if (max_price && min_price).present? #価格で絞込み
       self.all.page(page).per(per).includes(:user,user: :user_names).order(order_by).where('price >= ? AND price <= ?', min_price, max_price)
    elsif target == "phone" #電話番号
       self.all.page(page).per(per).includes(user: :user_names).joins(:user).order(order_by).where("customer_phone = ?", search)
    elsif target == "products" #商品番号で検索
       self.all.page(page).per(per).includes(:user,user: :user_names).order(order_by).joins(:order_product_infos).where('order_product_infos.product_id = ?', search.to_i)
      #elsif order_id,user_user.customer_phone,user_name,受注期間で絞り込み
    else
       self.includes(:user,user: :user_names).all.page(page).per(per).order(order_by)
    end
  end

  def self.get_list_by_status(status,page,per,order_by,target,search,max_price,min_price)
    if (max_price && min_price).present? #価格で絞込み
       self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by).where('price >= ? AND price <= ?', min_price, max_price)
    elsif target == "phone" #電話番号
       self.where(order_status: status).page(page).per(per).includes(user: :user_names).joins(:user).order(order_by).where("customer_phone = ?", search)
    elsif target == "products" #商品番号で検索
       self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by).joins(:order_product_infos).where('order_product_infos.product_id = ?', search.to_i)
    else
     self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by)
    end
  end
#Order.includes(:user,user: :user_names).where('products.search = ?', params[:category])


end