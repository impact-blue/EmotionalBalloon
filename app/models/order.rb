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

  #phoneのバリデーション
  validates :phone,
    presence:  { message: 'は必須です' },
    length: { in: 10..15 , message: 'は10桁から15桁です。'},
    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}

  validates :option,
    exclusion: { in: %w({ }  . [ ] ) }


#order_dateはやってない。create_atでよくね？


  def self.get_list_all(page,per,order_by,product_id,category_id,max_price,min_price)
    if (max_price && min_price).present? #価格で絞込み
       self.all.page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names).joins(:products).where('products.category_id = ?', category_id)
    elsif category_id.present? #カテゴリーで絞込み
       self.all.page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names).joins(:products).where('products.category_id = ?', category_id)
    elsif product_id.present? #商品番号で検索
       self.all.page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names).joins(:products).where('products.id = ?', product_id)
    else
       self.includes(:user,user: :user_names).all.page(page).per(per).order(order_by)
    end
  end

  def self.get_list_by_status(status,page,per,order_by,product_id,category_id,max_price,min_price)
    if (max_price && min_price).present? #価格で絞込み
       self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names).joins(:products).where('products.category_id = ?', category_id)
    elsif category_id.present? #カテゴリーで絞込み
       self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names).joins(:products).where('products.category_id = ?', category_id)
    elsif product_id.present? #商品番号で検索
       self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names).joins(:products).where('products.id = ?', product_id)
    else
     self.where(order_status: status).page(page).per(per).includes(:user,user: :user_names).order(order_by).includes(:user,user: :user_names)
    end
  end
#Order.includes(:user,user: :user_names).page(params[:page]).per(@per).order("id ASC").joins(:products).where('products.category_id = ?', params[:category])


end