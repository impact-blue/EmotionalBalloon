class Chara < ActiveRecord::Base
  has_many :product_charas
  has_many :products, through: :product_charas
end
