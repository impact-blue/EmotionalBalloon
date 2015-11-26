class Order < ActiveRecord::Base
  belongs_to :products
  belongs_to :payment #未
  belongs_to :user
  belongs_to :city
  belongs_to :scene
end
