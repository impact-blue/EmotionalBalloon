class Order < ActiveRecord::Base
  belongs_to :products
  belongs_to :payment #未
  belongs_to :user #未
  belongs_to :city #未
  belongs_to :scene
end
