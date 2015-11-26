class ProductScene < ActiveRecord::Base
  belongs_to :product
  belongs_to :scene
end
