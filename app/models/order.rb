class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :payment #未
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :city
  belongs_to :scene
end
