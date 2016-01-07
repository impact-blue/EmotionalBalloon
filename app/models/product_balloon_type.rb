class ProductBalloonType < ActiveRecord::Base
  belongs_to :product
  belongs_to :balloon_type
end
