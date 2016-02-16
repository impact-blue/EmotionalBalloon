class OrderProductInfo < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :order_id,:product_id,presence: {message: 'は必須です'}
end
