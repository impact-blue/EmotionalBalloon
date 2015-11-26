class City < ActiveRecord::Base
  has_many :orders
  has_many :users
end
