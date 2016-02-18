class OrderProductInfo < ActiveRecord::Base
  belongs_to :order, foreign_key: 'order_id'
  belongs_to :product

  validates :product_id,presence: true
end
