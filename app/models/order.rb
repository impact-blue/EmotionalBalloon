class Order < ActiveRecord::Base
  has_many :products, through: :product_orders
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :city
  belongs_to :scene
  has_many   :order_product_infos
  has_many :order_delivery_names
  #has_many :user_names

  accepts_nested_attributes_for :order_delivery_names


  validates :user_id,:price, presence: true,
                                           numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}
  #phoneのバリデーション
  validates :phone, presence:  { message: 'は必須です' },
                    length: { in: 10..15 , message: 'は10桁から15桁です。'},
                    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}

  #postal_codeのバリデーション
  validates :postal_code, presence: { message: 'は必須です' },
                          numericality: {only_integer: true, :message => "は半角数字のみ入力できます" },
                          length: {maximum: 9,wrong_length: 'の桁数が違います。'}

  #cityのバリデーション
  validates :city, presence: { message: 'は必須です' },
                   exclusion: { in: %w({ }  . [ ] ) }

  #addressのバリデーション
  validates :delivery_address, presence: { message: 'は必須です' },
                      exclusion: { in: %w({ }  . [ ] ) }
  validates :order_status, exclusion: { in: %w({ }  . [ ] ) }


end