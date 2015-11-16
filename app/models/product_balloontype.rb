class ProductBalloontype < ActiveRecord::Base
  belongs_to :product
  belongs_to :balloontype
end
