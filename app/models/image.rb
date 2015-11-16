class Image < ActiveRecord::Base
  has_many :product_images
  has_many :products, through: :product_images
end
