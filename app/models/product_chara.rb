class ProductChara < ActiveRecord::Base
  belongs_to :product
  belongs_to :chara
end
