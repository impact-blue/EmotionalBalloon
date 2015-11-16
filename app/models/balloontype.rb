class Balloontype < ActiveRecord::Base
  has_many :product_balloontypes
  has_many :products, through: :product_balloontypes
end
