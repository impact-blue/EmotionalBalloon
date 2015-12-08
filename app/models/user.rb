class User < ActiveRecord::Base
  has_many :orders
  belongs_to :city

  validates_confirmation_of :email
end
