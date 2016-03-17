class OrderProductInfo < ActiveRecord::Base
  belongs_to :order, foreign_key: 'order_id'
  belongs_to :product

  validates :product_id,:order_id,:count,:sum_price,
                    presence: true,
                    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}
end
