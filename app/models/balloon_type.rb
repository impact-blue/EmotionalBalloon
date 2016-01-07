class BalloonType < ActiveRecord::Base
  has_many :product_balloon_types
  has_many :products, through: :product_balloon_types
end
