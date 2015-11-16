class ProductCharacter < ActiveRecord::Base
  belongs_to :product
  belongs_to :character
end
