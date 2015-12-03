class Scene < ActiveRecord::Base
  has_many :product_scenes
  has_many :products, through: :product_scenes
  has_many :orders
end
