class Character < ActiveRecord::Base
  has_many :product_characters
  has_many :products, through: :product_characters
end
