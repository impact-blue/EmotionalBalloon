class Product < ActiveRecord::Base
  has_many :product_colors
  has_many :colors, through: :product_colors
  has_many :product_characters
  has_many :characters, through: :product_characters
  has_many :product_balloontypes
  has_many :balloontypes, through: :product_balloontypes
  has_many :product_images
  has_many :images, through: :product_images
  has_many :orders
  belongs_to :boxsize
end